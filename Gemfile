source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "bootsnap", require: false
gem "carrierwave"
gem "cssbundling-rails"
gem "devise"
gem "devise-i18n"
gem "dotenv-rails"
gem "font-awesome-sass"
gem "jbuilder"
gem "jsbundling-rails"
gem "mailjet"
gem "puma", "~> 5.0"
gem "pundit"
gem "rails-i18n"
gem "rails", "~> 7.0.4"
gem "resque"
gem "rmagick"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "pg", "~> 1.1"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails"
end

group :development do
  gem "web-console"
  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano-passenger"
  gem "capistrano-rbenv"
  gem "capistrano-bundler"
  gem "capistrano-resque", require: false
  gem "ed25519"
  gem "bcrypt_pbkdf"
  gem "letter_opener"
  gem "resque-web", require: "resque_web"
end

group :production do
  gem "pg", "~> 1.1"
end
