defmodule CurrencyConverter.Transaction.Converter do
  def run(rates, origin_currency, origin_amount, destination_currency)
      when origin_currency === "EUR" do
    IO.inspect(rates)
  end

  def run(rates, origin_currency, origin_amount, destination_currency)
      when origin_currency === "USD" do
    IO.inspect("DOLAR")
  end

  def run(rates, origin_currency, origin_amount, destination_currency)
      when origin_currency === "BRL" do
    IO.inspect("BRL")
  end

  def run(_) do
    IO.inspect("nada aqui")
  end
end
