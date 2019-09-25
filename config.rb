# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :minify_css
  activate :minify_javascript
end

activate :blog do |blog|
  blog.name = "blog"
  # blog.prefix = "blog"
  blog.permalink = "blog/{title}.html"
  blog.sources = "posts/{title}.html"
  blog.layout = "post"
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "posts/page/{num}"
  blog.tag_template = "tag.html"
  blog.taglink = "tags/{tag}.html"
end

activate :blog do |blog|
  blog.name = "podcast"
  blog.prefix = "podcast"
  blog.sources = "episodes/{title}.html"
  blog.layout = "episode"
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "episodes/page/{num}"
  blog.tag_template = "tag.html"
  blog.taglink = "tags/{tag}.html"
end

# configure :development do
#   set :css_dir, 'source/stylesheets'
#   set :js_dir, 'source/javascripts'
#   set :images_dir, 'source/images'
# end
#
# configure :production do
#   set :css_dir, 'source/stylesheets'
#   set :js_dir, 'source/javascripts'
#   set :images_dir, 'source/images'
# end
