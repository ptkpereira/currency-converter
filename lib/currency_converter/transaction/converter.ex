defmodule CurrencyConverter.Transaction.Converter do
  @moduledoc """
  Convert currency according to parameters
  """

  alias CurrencyConverter.Transaction.ExchangeRatesApi

  @currencies ["BRL", "USD", "JPY", "EUR"]
  # Origin Currency is EUR
  def run(origin_currency, origin_amount, destination_currency)
      when origin_currency === "EUR" do
    case check_params_and_get_api(origin_currency, origin_amount, destination_currency) do
      {:ok, rates} ->
        destination_amount =
          number_convert(origin_amount)
          |> Decimal.mult(number_convert(rates[destination_currency]))
          |> Decimal.round(4)

        rate = rates[destination_currency]

        {:ok, rate, destination_amount}

      {:error, reason} ->
        {:error, reason}
    end
  end

  # Destination Currency is EUR
  def run(origin_currency, origin_amount, destination_currency)
      when destination_currency === "EUR" do
    case check_params_and_get_api(origin_currency, origin_amount, destination_currency) do
      {:ok, rates} ->
        destination_amount = convert_to_eur(rates, origin_currency, origin_amount)

        rate =
          Decimal.div(destination_amount, number_convert(origin_amount))
          |> Decimal.round(7)

        {:ok, rate, destination_amount}

      {:error, reason} ->
        {:error, reason}
    end
  end

  # Origin and Destination Currency is not EUR
  def run(origin_currency, origin_amount, destination_currency)
      when origin_currency in @currencies and destination_currency in @currencies do
    case check_params_and_get_api(origin_currency, origin_amount, destination_currency) do
      {:ok, rates} ->
        # Convert Origin to EUR
        destination_amount =
          convert_to_eur(rates, origin_currency, origin_amount)
          # Convert total EUR to Destination
          |> Decimal.mult(number_convert(rates[destination_currency]))
          |> Decimal.round(4)

        rate =
          Decimal.div(destination_amount, number_convert(origin_amount))
          |> Decimal.round(7)

        {:ok, rate, destination_amount}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def run(_, _, _) do
    {:error, "params not found"}
  end

  # Validates the parameters before request the API
  def check_params_and_get_api(origin_currency, origin_amount, destination_currency) do
    case test_params(origin_currency, origin_amount, destination_currency) do
      :ok -> ExchangeRatesApi.get_rates()
      {:error, reason} -> {:error, reason}
    end
  end

  # Validates parameter types
  defp test_params(origin_currency, origin_amount, destination_currency) do
    cond do
      origin_currency not in @currencies ->
        {:error, "origin currency not found"}

      is_binary(origin_amount) ->
        {:error, "origin amount not found"}

      destination_currency not in @currencies ->
        {:error, "destination_currency not found"}

      is_binary(origin_currency) and is_binary(destination_currency) and
          is_number(origin_amount) ->
        :ok

      true ->
        {:error, "params not found"}
    end
  end

  defp number_convert(num) when is_integer(num) do
    Decimal.new(num)
  end

  defp number_convert(num) when is_float(num) do
    Decimal.from_float(num)
  end

  defp convert_to_eur(rates, origin_currency, origin_amount) do
    number_convert(origin_amount)
    |> Decimal.div(number_convert(rates[origin_currency]))
    |> Decimal.round(4)
  end
end
