# Description
Application to plan events.

## Supported features
- Registration&Authorization ([**Devise**](https://github.com/heartcombo/devise))
- Avatar & Photo upload ([**Carrierwave**](https://github.com/carrierwaveuploader/carrierwave), [**RMagick**](https://github.com/rmagick/rmagick))
- OmniAuth ([**GitHub OAuth**](https://github.com/omniauth/omniauth-github), [**VK OAuth**](https://github.com/mamantoha/omniauth-vkontakte))
- Users e-mail notification (**ActionMailer** + [**MailJet**](https://github.com/mailjet/mailjet-gem)) powered as side-job with **Redis** + [**Resque**](https://github.com/resque/resque) + [**Capistrano**](https://github.com/capistrano/rails) 

## Setup
1. Required Ruby (v. 3.1.2) & Rails (v. 7) installed on your PC.
2. Clone application to local PC:
```
git clone git@github.com:Godlikefreq/bbq.git
```
4. Run
```
bundle install
```

### Database setup
1. To specify database name, adapter and other parameters for different scopes change it in `config/database.yml`. 
Default DB adapter is **PostgreSQL** ([**Install PostgreSQL on Ubuntu 20.04**](https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-20-04-quickstart#step-1-installing-postgresql)).

2. Make new database ([**Create DB in PostgreSQL**](https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-20-04-quickstart#step-4-creating-a-new-database)).
3. Run
```
bundle exec rails db:migrate
```

### E-mail notifications setup
1. Create Mailjet account ([**Registration**](https://app.mailjet.com/signup?lang=en_US&_ga=2.53204394.347514357.1678029750-706275624.1673189233)) and setup new sender.
2. Make `.env` file in root directory.
3. Configure ENV variables:
```ruby
MAILJET_API_KEY = ******
MAILJET_SECRET_KEY = ******
MAILJET_SENDER = ******
```
4. Configure `config/environments/production.rb`:
```ruby
config.action_mailer.asset_host = 'http://myapp.example.com'
config.action_mailer.default_url_options = { :host => "myapp.example.com"}
```

#### Redis setup
Install and configure Redis ([**Instruction for Ubuntu 20.04**](https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-20-04))

#### Capistrano setup
1. Configure `config/deploy.rb`:
```ruby
set :application, "appname"
set :repo_url, "git@github.com:User/myapp.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/username/appname"
set :branch, "main"
```
2. Configure `config/deploy/production.rb`:
```ruby
server "myapp.example.com", user: "username", roles: %w{app db web resque_worker}

set :resque_environment_task, true
set :workers, { "#{fetch(:application)}*" => 1 }
```

### OAuth setup
1. Create new applications in developers menu [**VK**](https://dev.vk.com/) and [**GitHub**](https://github.com/settings/developers) 
2. Configure ENV variables:
```ruby
VK_API_ID = ******
VK_API_SECRET = ******
GITHUB_ID = ******
GITHUB_SECRET = ******
```

## Run locally
1. To run application on your local machine run following command in console:
```
rails s
```
2. Open `http://localhost:3000/` in your browser.

## Deployment
Deploy new versions of application with:
```
cap production deploy
```

## Live demo of working app
[**Application here**](http://bbq.mylessondomain.ru/)

## Sources
- Powered with [**Bootstrap 5**](https://getbootstrap.com/docs/5.0/getting-started/introduction/)
- Made and tested on **Ruby 3.1.2** & **Rails 7**
