defmodule CurrencyConverterWeb.TransactionView do
  use CurrencyConverterWeb, :view

  def render("index.json", %{transactions: transactions}) do
    %{transactions: render_many(transactions, __MODULE__, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{transaction: render_one(transaction, __MODULE__, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    transaction
    |> Map.from_struct()
    |> Map.put(
      :destination_amount,
      calculate_amount(transaction.origin_amount, transaction.rate)
    )
    |> Map.put(:date_time, transaction.inserted_at)
    |> Map.take([
      :id,
      :user_id,
      :origin_currency,
      :origin_amount,
      :destination_currency,
      :destination_amount,
      :rate,
      :date_time
    ])
  end

  defp calculate_amount(origin_amount, rate) do
    Decimal.mult(origin_amount, rate)
    |> Decimal.round(2)
  end
end
