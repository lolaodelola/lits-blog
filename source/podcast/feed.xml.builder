---
layout: false
blog: podcast
---
root_url = "https://lostinthesource.com"
feed_url = URI.join(root_url, current_page.path)

desired_blog = blog('podcast')
articles = desired_blog.articles
page_url = URI.join(root_url, "#{desired_blog.options.prefix.to_s}")

xml.instruct!
xml.feed "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.tag!("atom:link", "href" => feed_url, "rel" => "self")
    xml.title "Lost in the Source"
    xml.link  "href" => page_url
    xml.ttl 60
    xml.language "en"
    xml.copyright "All rights reserved"
    xml.webmaster "lostinthesource@lolaodelola.dev"
    xml.description "Tech news &amp; views"
    xml.author { xml.name "Lola Odelola" }
    xml.tag!("itunes:subtitle", "Tech news &amp; views")
    xml.tag!("itunes:owner") do
      xml.tag!("itunes:name", "Lost in the Source")
      xml.tag!("itunes:email", "lostinthesource@lolaodelola.com")
    end
    xml.tag!("itunes:author", "Lola Odelola")
    xml.tag!("itunes:explicit", "no")
    xml.tag!("itunes:image", "http://i1.sndcdn.com/avatars-000617179467-xzs3zc-original.jpg")
    xml.image do
      xml.url "http://i1.sndcdn.com/avatars-000617179467-xzs3zc-original.jpg"
      xml.title "Lost in the Source"
      xml.link "href" => page_url
    end
    xml.tag!("itunes:category", "text" => "Technology")

    xml.pudate(articles.first.date.to_time.iso8601) unless articles.empty?
    xml.last_build_date(articles.first.date.to_time.iso8601) unless articles.empty?

    articles.each do |article|
      article_url = URI.join(root_url, article.url)
      xml.item do
        xml.title article.title
        xml.link "rel" => "alternate", "href" => article_url
        xml.guid article_url, "isPermalink" => "false"
        xml.published article.date.to_time.iso8601
        xml.updated article.date.to_time.iso8601
        xml.author { xml.name "Lola Odelola" }
        xml.summary article.summary(500), :type => "html"
        xml.content article.body, "type" => "html"
        xml.tag!("itunes:duration", article.data.duration)
        xml.tag!("itunes:author", "Lola Odelola")
        xml.tag!("itunes:image", "href" => "http://i1.sndcdn.com/artworks-000527269293-h4jhi0-original.jpg")
        xml.tag!("itunes:explicit", "no")
        xml.tag!("itunes:summary", article.data.description)
        xml.tag!("itunes:subtitle", "no")
        xml.description article.data.description
        xml.enclosure "type" => "audio/mpeg", "url" => article.data.audio_link, "length" => 0
      end
    end
  end
end