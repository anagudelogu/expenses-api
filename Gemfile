source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Code linter. [https://github.com/rubocop/rubocop]
gem 'rubocop', require: false

# Code linter. [https://github.com/rubocop/rubocop-rails]
gem 'rubocop-rails', require: false

# Test linter. [https://github.com/rubocop/rubocop-rspec]
gem 'rubocop-rspec', require: false

# Performance linter [https://github.com/rubocop/rubocop-performance]
gem 'rubocop-performance', require: false

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  # Testing library [https://github.com/rspec/rspec-rails]
  gem 'rspec-rails', '~> 6.0.0'

  # Fixtures [https://github.com/thoughtbot/factory_bot_rails]
  gem 'factory_bot_rails'

  # Identify n+1 queries [https://github.com/flyerhzm/bullet]
  gem 'bullet'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
