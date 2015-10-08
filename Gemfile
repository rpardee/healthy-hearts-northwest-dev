source 'https://rubygems.org'
ruby '2.1.5'

gem 'devise', '~> 3.5.1'
gem 'american_date', '~> 1.1.0'
gem 'rails_12factor', group: :production

# Authorization
gem 'pundit', '~> 1.0.1'

# Auditing
gem 'paper_trail', '~> 4.0.0'

# Allow jQuery to hit a CDN
gem 'jquery-rails-cdn', '~> 1.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.2'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Handle nested forms easily
gem 'cocoon', '~> 1.2.6'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
	# Error tracking
	gem 'rollbar', '~> 1.2.7'

	# Web server
	gem 'puma', '~> 2.14.0'
	gem 'rack-timeout', '~> 0.3.2'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Email test
  gem 'letter_opener', '~> 1.4.1'
  # Look for queries to optimize
  gem 'bullet', '~> 4.14.7'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
