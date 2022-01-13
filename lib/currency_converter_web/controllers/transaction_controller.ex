defmodule CurrencyConverterWeb.TransactionController do
  use CurrencyConverterWeb, :controller

  alias CurrencyConverter.Transaction.{
    ListTransactions,
    GetTransaction,
    NewTransaction,
    ExchangeRatesApi,
    Converter
  }

  alias CurrencyConverter.Accounts.GetUser

  def index(conn, _params) do
    transactions = ListTransactions.run()
    render(conn, "index.json", transactions: transactions)
  end

  def show(conn, %{"id" => id}) do
    transaction = GetTransaction.run(id)
    render(conn, "show.json", transaction: transaction)
  end

  def create(conn, %{"transaction" => transaction_params, "user_id" => user_id}) do
    user = GetUser.run(user_id)

    result =
      ExchangeRatesApi.get_rates()
      |> Converter.run(
        transaction_params["origin_currency"],
        transaction_params["origin_amount"],
        transaction_params["destination_currency"]
      )

    case NewTransaction.run(
           transaction_params
           |> Map.merge(%{"user_id" => user.id})
         ) do
      {:ok, transaction} ->
        conn
        |> put_status(:created)
        |> render("show.json", transaction: transaction)

      {:error, _} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{status: "unprocessable entity"})
    end
  end
end
