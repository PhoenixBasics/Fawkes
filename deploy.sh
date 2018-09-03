heroku create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git"
heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git
touch Procfile
echo "web: MIX_ENV=prod mix phx.server" > Procfile
heroku addons:create heroku-postgresql:hobby-dev
heroku config:set POOL_SIZE=18
heroku config:set SECRET_KEY_BASE="GENERATE KEY"
heroku config:set GUARDIAN_KEY="GENERATE KEY"

heroku config:set S3_BUCKET="nhu-fawkes"
heroku config:set AWS_ACCESS_KEY="YOUR KEY"
heroku config:set AWS_SECRET_KEY="YOUR SECRET"

git push heroku 10.bonus1:master

heroku run "POOL_SIZE=2 mix ecto.migrate"
heroku run "POOL_SIZE=2 mix run priv/repo/seeds.exs"
