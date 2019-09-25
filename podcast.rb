require 'dotenv/load'
require 'rb-readline'
require 'aws-sdk-s3'
require 'aws-sdk-transcribeservice'
require 'pry'

@audio_path = ARGV[0]
@file_name = ARGV[1]


credentials =  Aws::Credentials.new(ENV['AWS_KEY'], ENV['AWS_SID'])

# S3 objects
s3_resource = Aws::S3::Resource.new(region: "eu-west-2", credentials: credentials)
s3_client = Aws::S3::Client.new(region: "eu-west-2", credentials: credentials)

# Transcribe object
aws_transcribe_client = Aws::TranscribeService::Client.new(region: "eu-west-2", credentials: credentials)

# Create audio object in S3
obj = s3_resource.bucket("lits-podcast-episodes").object("#{@file_name}.mp3")
puts "Uploading audio"
if obj.upload_file(@audio_path)
  puts "done"
  @audio_url = s3_resource.bucket('lits-podcast-episodes').object("#{@file_name}.mp3").public_url
else
  puts "nope"
end

puts "Starting transcription job"
aws_transcribe_client.start_transcription_job({
                             transcription_job_name: @file_name, # required
                             language_code: "en-GB", # required,
                             media_sample_rate_hertz: 44_100,
                             media_format: "mp3", # required
                             media: { # required
                                      media_file_uri: @audio_url,
                             },
                             output_bucket_name: 'lits-podcast-episodes'
})

s3_client.wait_until(:object_exists, {bucket: 'lits-podcast-episodes', key: "#{@file_name}.json"}) do |w|
  w.max_attempts = 10
  w.delay = 120
end
puts "Fetiching transcript"
draft_transcript = s3_client.get_object({
                  bucket: 'lits-podcast-episodes',
                  key: "#{@file_name}.json"
})

# Parse transcript
draft_transcript_body = JSON.parse(draft_transcript.body.read)["results"]["transcripts"][0]["transcript"]
puts "Writing to episode post"
File.open("source/podcast/episodes/#{@file_name}.html.markdown", "a") do |file|
  file.puts "---"
  file.puts "title: #{@file_name}"
  file.puts "blog: podcast"
  file.puts "published: false"
  file.puts "date:"
  file.puts "---"
  file.puts @audio_url
  file.puts draft_transcript_body
end
