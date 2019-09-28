---
layout: false
blog: blog
---
root_url = "https://lostinthesource.com"
feed_url = URI.join(root_url, current_page.path)

desired_blog = blog('blog')
articles = desired_blog.articles
page_url = URI.join(root_url, "#{desired_blog.options.prefix.to_s}/")

xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title "Lost in the Source - Blog"
  xml.subtitle "Posts by Lola"
  xml.id page_url
  xml.link "href" => page_url
  xml.link "href" => feed_url, "rel" => "self"
  xml.updated(articles.first.date.to_time.iso8601) unless articles.empty?
  xml.author { xml.name "Lola Odelola" }

  articles[0..5].each do |article|
    article_url = URI.join(root_url, article.url)
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => article_url
      xml.id article_url
      xml.published article.date.to_time.iso8601
      xml.updated article.date.to_time.iso8601
      xml.author { xml.name "Lola Odelola" }
      xml.summary article.summary(500), :type => "html"
      xml.content article.body, "type" => "html"
    end
  end
end