# Currency Converter API

<!-- ABOUT THE PROJECT -->

## About The Project

A currency converter REST API that uses the rates of Exchanges Rates API and storage all conversions.

Uses [Credo](https://github.com/rrrene/credo) for quality and code consistency.

For to make easier the access to the Exchanges Rates endpoint, uses [Tesla](https://github.com/teamon/tesla).

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With

- [Elixir](https://elixir-lang.org/)
- [Phoenix](https://www.phoenixframework.org/)
- [PostgreSQL](https://www.postgresql.org/)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->

## Getting started

### Set Exchanges Rates API key

- Create account and get a free API Key in [`https://exchangeratesapi.io/`](https://exchangeratesapi.io/)
- Rename `.env.example` to `.env` and put your API Key

### Database

- If you have [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) installed, just run `docker-compose up` or `docker-compose up -d` if you want run container in background.
- Else, you will need install [PostgreSQL](https://www.postgresql.org/)

### Start Phoenix server

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Source enviroment variables `source .env`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now the API will be listening for your requests at [`localhost:4000`](http://localhost:4000)

<!-- DOCUMENTATION -->

## Documentation

- Run this code and generate the documentation `mix docs`
- This will generate a `doc/` directory with a documentation in HTML. Open the `index.html` file this directory in the browser to view the documentation.

<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>
