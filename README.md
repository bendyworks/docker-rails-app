# README

This is a companion repo to the Wrangling Complex Rails apps with Docker blog series.

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
