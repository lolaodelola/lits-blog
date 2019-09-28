require 'dotenv/load'
require 'rb-readline'
require 'time'
require 'aws-sdk-s3'
require 'aws-sdk-transcribeservice'
require 'pry'

@audio = {
  path: ARGV[0],
  name: ARGV[1]
}

# Metadata setup
puts "Setup metadata"
get_duration = `mdls -name kMDItemDurationSeconds #{@audio[:path]}`
duration_seconds = get_duration.gsub('kMDItemDurationSeconds =', '').strip
@audio[:duration] = Time.at(duration_seconds.to_f).utc.strftime('%H:%M:%S')

get_sample_rate = `mdls -name kMDItemAudioSampleRate #{@audio[:path]}`
@audio[:sample_rate] = get_sample_rate.gsub('kMDItemAudioSampleRate =', '').strip
puts "Metadata setup complete"

# AWS setup
credentials =  Aws::Credentials.new(ENV['AWS_KEY'], ENV['AWS_SID'])
s3_resource = Aws::S3::Resource.new(region: 'eu-west-2', credentials: credentials)
s3_client = Aws::S3::Client.new(region: 'eu-west-2', credentials: credentials)
transcribe_client = Aws::TranscribeService::Client.new(region: 'eu-west-2', credentials: credentials)

# # Create audio object in S3
# puts "Upload audio to S3"
# File.open(@audio[:path], 'rb') do |file|
#   s3_client.put_object(
#       acl: 'public-read',
#       body: file,
#       bucket: ENV['AWS_BUCKET'],
#       key: "audio/#{@audio[:name]}.mp3",
#       metadata: {
#           duration: @audio[:duration],
#           sample_rate: @audio[:sample_rate]
#       }
#   )
# end
# puts "Audio upload complete"
#
# @audio[:url] = s3_resource.bucket(ENV['AWS_BUCKET']).object("audio/#{@audio[:name]}.mp3").public_url
#
# puts 'Starting transcription job'
# transcribe_client.start_transcription_job(
#    transcription_job_name: @audio[:name], # required
#    language_code: 'en-GB', # required,
#    media_sample_rate_hertz: @audio[:sample_rate].to_i,
#    media_format: 'mp3', # required
#    media: { # required
#             media_file_uri: @audio[:url]
#    },
#    output_bucket_name: ENV['AWS_BUCKET']
# )
#
# s3_client.wait_until(:object_exists, bucket: ENV['AWS_BUCKET'], key: "#{@audio[:name]}.json") do |w|
#   w.max_attempts = 10
#   w.delay = 120
# end
# puts "Finished transcription job"

puts 'Fetiching transcript'
draft_transcript = s3_client.get_object(
  bucket: ENV['AWS_BUCKET'],
  key: "#{@audio[:name]}.json"
)

# Parse transcript
draft_transcript = JSON.parse(draft_transcript.body.read)['results']['transcripts'][0]['transcript']
puts 'Writing to episode post'
File.open("source/podcast/episodes/#{@audio[:name]}.html.markdown", 'w') do |file|
  file.puts "---"
  file.puts "title: #{@audio[:name]}"
  file.puts "blog: podcast"
  file.puts "published: false"
  file.puts "date:  #{Time.now}"
  file.puts "duration: #{@audio[:duration]}"
  file.puts "description:"
  file.puts "audio_link: #{@audio[:url]}"
  file.puts "---"
  file.puts "<audio controls src='#{@audio[:url]}'>
      Your browser does not support the <code>audio</code> element.
    </audio>"
  file.puts "\n" # Add double space
  file.puts "Transcript unavailable"
  file.puts "\n"
  file.puts "[//]: # (#{draft_transcript})"
end
