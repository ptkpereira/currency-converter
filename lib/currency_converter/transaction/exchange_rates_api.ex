defmodule CurrencyConverter.Transaction.ExchangeRatesApi do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.exchangeratesapi.io"
  plug Tesla.Middleware.Headers, [{"content-type", "application/json"}]
  plug Tesla.Middleware.JSON

  def get_rates do
    %{
      success: true,
      timestamp: 1_642_093_743,
      base: "EUR",
      date: "2022-01-13",
      rates: %{
        BRL: 6.321126,
        USD: 1.146441,
        JPY: 130.761886
      }
    }
    |> Map.get(:rates)
  end
end
