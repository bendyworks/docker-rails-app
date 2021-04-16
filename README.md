# README

This is a companion repo to the Wrangling Complex Rails apps with Docker.

In order to run this app:

Install the example env files:

.env.docker.development:

```
DATABASE_URL="postgres://myuser:letmein@db/appdb"
BUNDLE_PATH=/bundle/vendor
```

- `docker-compose up --build`
- `docker-compose exec web rails db:migrate`
- open http://localhost:3000


## Common Rails tasks:

### Start a console

```
docker-compose exec web rails console
```

### Generate a model/migration/scaffold, etc.

```
docker-compose exec web rails generate model Thing
```

### Install or update a rubygem

```
docker-compose exec web bundle add rspec -g test
docker-compose exec web bundle update rails

# Rebuild the image since the Gemfile.lock has changed
docker-compose build 
```

### Testing

```
docker-compose exec test rails test test/models/todo_test.rb
```