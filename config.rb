require 'slim'

# General configuration --------------------------------------------------------

# We use single quotes for HTML attributes so that viewloader can be parsed.
Slim::Engine.set_options attr_quote: "'"
Slim::Engine.default_options[:pretty] = true

activate :dotenv

# Set Markdown engine to use redcarpet
set :markdown_engine, :redcarpet
set :markdown,        fenced_code_blocks: true,
                      autolink: true,
                      smartypants: true,
                      hard_wrap: true,
                      smart: true,
                      superscript: true,
                      no_intra_emphasis: true,
                      lax_spacing: true,
                      with_toc_data: true

# Set asset directories to nothing
config[:js_dir] = ''
config[:css_dir] = ''
config[:images_dir] = ''

# Helpers ----------------------------------------------------------------------

require "lib/typography_helpers"
helpers TypographyHelpers
require "lib/asset_helpers"
helpers AssetHelpers

# Methods defined in the helpers block are available in templates
# Add custom ones below
#
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Page options -----------------------------------------------------------------

# Page rules are matched in order from top to bottom.
#
# Example configuration options:
# With no layout:
#
#   page "/path/to/file.html", layout: false
#
# With alternative layout:
#
#   page "/path/to/file.html", layout: :other_layout
#
# A path which all have the same layout:
#
#   with_layout :admin do
#     page "/admin/*"
#   end

# Proxy (fake) files:
#   page "/this-page-has-no-template.html", proxy: "/template-file.html" do
#     @which_fake_page = "Rendering a fake page with a variable"
#   end

# Pages without layout
page "*.xml", layout: false
page "*.json", layout: false
page "*.txt", layout: false

# Catch-all for other routes
page "*", layout: "layouts/base"

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# Webpack configuration --------------------------------------------------------

activate :external_pipeline,
         name: "icelab-assets",
         command: build? ? "yarn run build" : "yarn run start",
         source: ".tmp/dist",
         latency: 1


# General configuration --------------------------------------------------------

activate :directory_indexes
#activate :asset_hash

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Build-specific configuration -------------------------------------------------

ignore "assets/**/*.css"
ignore "assets/**/*.js"

configure :build do
end

# Deployment configuration -----------------------------------------------------

# Deploy to GitHub Pages
#
# activate :deploy do |config|
#   config.deploy_method = :git
#   config.branch = "gh-pages"
#   config.build_before = true
# end

# Deploy to S3
#
# You’ll need to fill in the credentials in your `.env`. Check the documentation
# for the middleman-s3_sync gem for more details <https://github.com/fredjean
# /middleman-s3_sync>
#
# activate :s3_sync do |s3_sync|
#   s3_sync.bucket                     = ENV["AWS_BUCKET"]
#   s3_sync.region                     = ENV["AWS_REGION"]
#   s3_sync.aws_access_key_id          = ENV["AWS_ACCESS_KEY_ID"]
#   s3_sync.aws_secret_access_key      = ENV["AWS_SECRET_ACCESS_KEY"]
#   s3_sync.delete                     = false
#   s3_sync.after_build                = false
#   s3_sync.prefer_gzip                = true
#   s3_sync.path_style                 = true
#   s3_sync.reduced_redundancy_storage = false
#   s3_sync.acl                        = 'public-read'
#   s3_sync.encryption                 = false
#   s3_sync.prefix                     = ''
#   s3_sync.version_bucket             = false
#   s3_sync.index_document             = 'index.html'
#   s3_sync.error_document             = '404.html'
# end
