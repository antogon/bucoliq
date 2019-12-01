# Bucoliq
A modest application to help plan the finer aspects of your outdoor adventures.

# Developer Notes
## Setting up the API Server
The API server in `/backend` is written with Elixir and Phoenix.

  * Set up Postgres locally (v12.1)
  * Configure the database details in `config/dev.exs` (or other files depending on your environment)
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To run the tests, try `mix test`.
