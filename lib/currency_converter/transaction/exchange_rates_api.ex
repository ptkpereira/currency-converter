defmodule CurrencyConverter.Transaction.ExchangeRatesApi do
  @moduledoc """
  Get rates in Exchange Rates Api
  """

  use Tesla

  plug Tesla.Middleware.BaseUrl,
       "http://api.exchangeratesapi.io/v1/latest?base=EUR&symbols=BRL,USD,JPY,EUR&"

  plug Tesla.Middleware.Query, access_key: System.get_env("API_KEY")

  plug Tesla.Middleware.Headers, [{"content-type", "application/json"}]
  plug Tesla.Middleware.JSON

  def get_rates do
    # Example
    # %{"BRL" => 6.3317, "JPY" => 130.7585929, "USD" => 1.146}

    case get("/") do
      {_, response} when response.status == 200 ->
        rates =
          response.body
          |> Map.get("rates")

        {:ok, rates}

      {_, response} when response.status != 200 ->
        reason =
          response.body
          |> Map.get("error")
          |> Map.get("message")

        {:error, reason}
    end
  end
end
