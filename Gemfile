source 'http://rubygems.org'
#gem 'rails', '3.0.3'  # required based 3.0.3, 3.0.4 is out, we are out of date :)
gem 'rails', '3.0.10'  # required based 3.0.3, 3.0.4 is out, we are out of date :)

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'addressable'       # URI replacement
gem 'cacheify'          # Cache method calls (redis support)
gem 'nokogiri'          # HTML, XML, SAC parser (supports XPath or CSS3 selectors)
gem 'devise'            # required for login support
gem 'nifty-generators'  # (opt) Rails generator scripts for scaffolding, layout files, authentication
# required for external authentication support for facebook, twitter, oauth, etc
#gem 'omniauth', '0.2.6', :git => "https://github.com/intridea/omniauth.git"
gem 'actionpack', '3.0.10'
gem 'omniauth', '~> 0.3'
gem 'oauth'

# required for memory key value pair store in Rails 3.x
#gem 'redis-store', :git => "https://github.com/jodosha/redis-store.git"
gem 'redis-store', '1.0.0.beta4'
#gem 'redis'             # required for memory key value pair store in Rails 3.x
gem 'redis', '2.2.1'

unless RUBY_PLATFORM[/mswin|mingw32/i]  # Microsoft Windows
  gem 'SystemTimer'       # to resolve rails 3 command line notification of timeout class
  gem "rack-timeout"      # to resolve rails 3 command line notification of timeout class
  gem 'unicorn'
  gem 'rainbows'
end

if RUBY_PLATFORM =~ /darwin/
  gem 'mysql2', '0.2.13'             # required for Database support on Mac
else
  gem 'mysql'             # required for Database support
end


gem 'jquery-rails'      # required for jquery support
gem 'yaml_db'
gem 'paperclip'         # required for attachment upload
gem 'aws-s3'            # required for amazon s3 usage
gem 'rqrcode'           # required to generated QR codes
#gem 'rmagick', '~> 2.13.1' # required to generate graphs on the fly

gem 'will_paginate', '~> 3.0.pre2'     # paginate by sql

# gem 'rails-footnotes',
#   :git => 'git://github.com/josevalim/rails-footnotes.git',
#   :branch => 'rails3', :group => :development  

#TODO: upgrade from app-config as this is the rails 3 version
#gem 'rails-config' 

group :test, :development do
  gem "rspec-rails", "~> 2.4"
  gem "rcov"
  gem "autotest"
  gem "cucumber"
  gem "cucumber-rails"
  gem "factory_girl_rails"
  gem 'faker'
  gem "capybara"
  gem 'nokogiri'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
