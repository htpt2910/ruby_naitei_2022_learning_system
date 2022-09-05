source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "3.0.2"

gem "bcrypt", "~> 3.1.7"
gem "cancancan", "3.4.0"
gem "config", "~> 4.0.0"
gem "devise", "~> 4.8.1"
gem "devise-i18n", "~> 1.10.2"
gem "faker", "~> 2.22.0"
gem "image_processing", "~> 1.2"
gem "jbuilder", "~> 2.7"
gem "mysql2", "~> 0.5"
gem "pagy", "~> 5.10.1"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.6", ">= 6.1.6.1"
gem "rails-i18n", "~> 7.0.5"
gem "ransack", "~> 3.2.1"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "view_component", "~> 2.66.0"
gem "webpacker", "~> 5.0"

gem "bootsnap", ">= 1.4.4", require: false

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails", "~> 6.2.0"
  gem "guard", "~> 2.18.0"
  gem "rspec-rails", "~> 5.1.2"
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-minitest", "~> 0.20.1", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end

group :development do
  gem "bullet", "~> 7.0.3"
  gem "guard-compat", "~> 1.2.1"
  gem "guard-rspec", require: false
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "solargraph"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "guard-minitest", "~> 2.4.6"
  gem "minitest", "~> 5.16.2"
  gem "minitest-reporters", "~> 1.5.0"
  gem "rails-controller-testing", "~> 1.0.5"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
  gem "shoulda-matchers"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
