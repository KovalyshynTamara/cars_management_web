source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "devise", "~>5.0"
gem "rails", "~> 8.1.2"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft", "~>1.3"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails", "~> 2.2"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails", "~> 2.0"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", "~> 1.3"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", "~> 2.14"

gem "tailwindcss-rails", "~> 4.4"
gem "pagy", "~> 6.4"
gem "ffaker", "~> 2.25"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
# gem "solid_cache"
# gem "solid_queue"
# gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "~> 1.22", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", "~> 2.10", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", "~> 0.1", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", "~> 1.11", platforms: %i[ mri windows ], require: "debug/prelude"

  # Audits gems for known security defects (use config/bundler-audit.yml to ignore issues)
  gem "bundler-audit", "~> 0.9", require: false

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", "~> 8.0", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", "~> 1.1", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console", "~> 4.2"
  gem "rubocop-performance", "~> 1.26", require: false
  gem "rubocop-rails", "~> 2.34", require: false
  gem "rubocop-rspec", "~> 3.9", require: false
  gem "rubocop-rake", "~> 0.7", require: false
  gem "strong_migrations", "~> 2.5"
  gem "bundler-leak", "~> 0.3", require: false
  gem "traceroute", "~> 0.8", require: false
  gem "fasterer", "~> 0.11", require: false
  gem "rspec-rails", "~> 8.0"
  gem "simplecov", "~> 0.22", require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara", "~> 3.40"
  gem "selenium-webdriver", "~> 4.40"
end
group :development, :test do
  gem "factory_bot_rails", "~> 6.5"
  gem "shoulda-matchers", "~> 7.0"
end
