defmodule CurrencyConverter.Transaction.Converter do
  @currencies ["BRL", "USD", "JPY"]
  def run(rates, origin_currency, origin_amount, destination_currency)
      when origin_currency === "EUR" do
    IO.inspect(rates)

    destination_amount =
      number_convert(origin_amount)
      |> Decimal.mult(number_convert(rates[destination_currency]))
      |> Decimal.round(4)

    rate = rates[destination_currency]

    {
      rate,
      destination_amount
    }
  end

  def run(rates, origin_currency, origin_amount, destination_currency)
      when destination_currency === "EUR" do
    destination_amount = convert_to_eur(rates, origin_currency, origin_amount)

    rate =
      Decimal.div(destination_amount, number_convert(origin_amount))
      |> Decimal.round(7)

    {
      rate,
      destination_amount
    }
  end

  # Origin and Destination Currency is not EUR
  def run(rates, origin_currency, origin_amount, destination_currency)
      when origin_currency in @currencies and destination_currency in @currencies do
    # Convert Origin to EUR
    destination_amount =
      convert_to_eur(rates, origin_currency, origin_amount)
      # Convert total EUR to Destination
      |> Decimal.mult(number_convert(rates[destination_currency]))
      |> Decimal.round(4)

    rate =
      Decimal.div(destination_amount, number_convert(origin_amount))
      |> Decimal.round(7)

    {
      rate,
      destination_amount
    }
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
