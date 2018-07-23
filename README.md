# Gutenberg

Gutenberg is an alternate interface for the Project Gutenberg collection.

# Deploy to dokku

`git remote add dokku dokku@<dokku-host-ip>:gutenberg`
`dokku apps:create gutenberg`
`dokku config:set --no-restart PORT=5000`
`dokku config:set --no-restart SECRET_KEY_BASE=<mix phx.gen.secret>`
`dokku config:set --no-restart WEB_HOST=<host>`
`dokku postgres:create gutenberg-database`
`dokku postgres:link gutenberg-database gutenberg`
`git push dokku master`
`dokku run mix ecto.migrate`
`dokku run mix run priv/repo/seeds.exs`
`dokku domains add gutenberg <domain>`