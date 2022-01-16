<div id="top"></div>

<!-- PROJECT HEADER -->
<br />
<div align="center">
  <h1 align="center">Currency Converter</h1>

  <p align="center">
    API for currency conversion
    <br />
    <a href="#documentation"><strong>Generate documentation »</strong></a>
    <br />
    <br />
    <a href="#getting-started">Install</a>
    ·
    <a href="#usage">How it works</a>
    ·
    <a href="#tests">Run Tests</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#api-key">Api Key</a></li>
        <li><a href="#database">Database</a></li>
        <li><a href="#instalation">Instalation</a></li>
      </ul>
    </li>
    <li>
      <a href="#usage">Usage</a>
      <ul>
        <li><a href="#routes">Routes</a></li>
        <li><a href="#hands-on">Hands On</a></li>
      </ul>
    </li>
    <li><a href="#documentation">Documentation</a></li>
    <li><a href="#tests">Tests</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

A currency converter REST API that uses the rates of Exchanges Rates API and storage all conversions. The project allows to add and list users, converter between two currencies and save the transaction with the corresponding user, get a transaction and list all conversions by user.

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

### API key

- Create account and get a free API Key in [`https://exchangeratesapi.io/`](https://exchangeratesapi.io/)
- Rename `.env.example` to `.env` and put your API Key

### Database

- If you have [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) installed, just run `docker-compose up` or `docker-compose up -d` if you want run container in background.
- Else, you will need install [PostgreSQL](https://www.postgresql.org/)

### Installation

- Install dependencies with `mix deps.get`
- Create and migrate database with `mix ecto.setup`
- Source enviroment variables `source .env`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now the API will be listening for your requests at [`localhost:4000`](http://localhost:4000)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE -->

## Usage

### Routes

| Methods | Endpoint                        | Body parameters                                      | Description               |
| ------- | ------------------------------- | ---------------------------------------------------- | ------------------------- |
| post    | /api/users                      | name                                                 | Create a user             |
| get     | /api/users                      |                                                      | List users                |
| get     | /api/users/id                   |                                                      | Show a single user        |
| post    | /api/users/user_id/transactions | origin_currency, destination_currency, origin_amount | Create a transaction      |
| get     | /api/users/user_id/transactions |                                                      | List transaction by user  |
| get     | /api/users/id                   |                                                      | Show a single transaction |

### Hands On

- Each transaction belongs to a user, so create a user to get started:

`Post /api/users`

```json
{
  "user": {
    "name": "Jane Doe"
  }
}
```

`Response example`

```json
{
  "user": {
    "id": 1,
    "inserted_at": "2015-10-21T07:28:00",
    "name": "Jane Smith",
    "updated_at": "2015-10-21T07:28:00"
  }
}
```

- Now you can convert the currencies and storage the transaction:

`Post /api/users/1/transactions`

```json
{
  "transaction": {
    "origin_currency": "EUR",
    "origin_amount": 42,
    "destination_currency": "USD"
  }
}
```

`Response example`

```json
{
  "transaction": {
    "date_time": "2015-10-21T07:28:00",
    "destination_amount": "47.95",
    "destination_currency": "USD",
    "id": 1,
    "origin_amount": "42",
    "origin_currency": "EUR",
    "rate": "1.141611",
    "user_id": 1
  }
}
```

PS, don't forget to get your API Key, to put in the .env.example file, rename it to .env and run `source .env`, otherwise you will get the error `You have not supplied an API Access Key. [Required format: access_key=YOUR_ACCESS_KEY]`.
<br />
<br />

- List all transactions by user

```
get /api/users/user_id/transactions
```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- DOCUMENTATION -->

## Documentation

- Run this code and generate the documentation `mix docs`
- This will generate a `doc/` directory with a documentation in HTML. Open the `index.html` file this directory in the browser to view the documentation.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- TESTS -->

## Tests

To run the tests, open this project in terminal and run `mix test`

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>
