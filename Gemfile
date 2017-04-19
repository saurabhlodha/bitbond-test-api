source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.0.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rack-cors'
gem 'devise'
gem 'jwt'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'koala'
gem 'twitter'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rb-readline'
  gem 'letter_opener'
  gem 'dotenv-rails', '~> 1.0.2'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
