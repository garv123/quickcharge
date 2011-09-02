source 'http://rubygems.org'

gem 'rails', '~>3.1.0'

gem 'jquery-rails'

gem 'omniauth', :git => "git://github.com/intridea/omniauth.git", :ref => "d4cc511"


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :production do
  gem 'therubyracer-heroku'
  gem 'pg'
end

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  gem 'sqlite3'
  gem 'cucumber-rails'
  gem 'rspec-rails'
  gem 'webrat'
  gem 'database_cleaner'
  gem 'launchy'
end

group :test do
  gem 'webmock'
end
