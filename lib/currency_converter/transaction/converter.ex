defmodule CurrencyConverter.Transaction.Converter do
  @moduledoc """
  Convert currency
  """

  alias CurrencyConverter.Transaction.ExchangeRatesApi

  @currencies ["BRL", "USD", "JPY", "EUR"]
  def run(origin_currency, origin_amount, destination_currency)
      when origin_currency === "EUR" do
    case check_params(origin_currency, origin_amount, destination_currency) do
      {:ok, _origin_currency, origin_amount, destination_currency} ->
        rates = ExchangeRatesApi.get_rates()

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

  def run(origin_currency, origin_amount, destination_currency)
      when destination_currency === "EUR" do
    case check_params(origin_currency, origin_amount, destination_currency) do
      {:ok, origin_currency, origin_amount, _destination_currency} ->
        rates = ExchangeRatesApi.get_rates()
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
    case check_params(origin_currency, origin_amount, destination_currency) do
      {:ok, origin_currency, origin_amount, destination_currency} ->
        rates = ExchangeRatesApi.get_rates()
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

  defp check_params(origin_currency, origin_amount, destination_currency) do
    cond do
      origin_currency not in @currencies ->
        {:error, "origin currency not found"}

      is_binary(origin_amount) ->
        {:error, "origin amount not found"}

      destination_currency not in @currencies ->
        {:error, "destination_currency not found"}

      is_binary(origin_currency) and is_binary(destination_currency) and
          is_number(origin_amount) ->
        {:ok, origin_currency, origin_amount, destination_currency}

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
