# Gutenberg

Gutenberg is an alternate interface for the Project Gutenberg collection.

# Deploy to dokku

```
git remote add dokku dokku@<dokku-host-ip>:gutenberg
git push dokku master
dokku config:set --no-restart PORT=5000
dokku config:set --no-restart SECRET_KEY_BASE=<mix phx.gen.secret>
dokku config:set --no-restart WEB_HOST=<host>
dokku postgres:create gutenberg-database
dokku postgres:link gutenberg-database gutenberg
dokku run mix ecto.migrate
dokku run mix run priv/repo/seeds.exs
dokku domains add gutenberg <domain>
dokku domains remove gutenberg gutenberg
dokku letsencrypt
```