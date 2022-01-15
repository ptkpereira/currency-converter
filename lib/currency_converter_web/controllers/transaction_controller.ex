defmodule CurrencyConverterWeb.TransactionController do
  use CurrencyConverterWeb, :controller

  alias CurrencyConverter.Transaction.{
    Converter,
    ExchangeRatesApi,
    GetTransaction,
    ListTransactions,
    NewTransaction
  }

  alias CurrencyConverter.Transaction

  alias CurrencyConverter.Accounts.GetUser

  action_fallback(CurrencyConverterWeb.FallbackController)

  def index(conn, %{"user_id" => user_id}) do
    user = GetUser.run(user_id)

    case user do
      nil ->
        conn
        |> put_status(:not_found)
        |> render(CurrencyConverterWeb.ErrorView, "404.json", assigns: "user")

      user ->
        user
    end

    transactions = ListTransactions.run(user)
    render(conn, "index.json", transactions: transactions)
  end

  def show(conn, %{"id" => id, "user_id" => user_id}) do
    user = GetUser.run(user_id)

    case user do
      nil ->
        conn
        |> put_status(:not_found)
        |> render(CurrencyConverterWeb.ErrorView, "404.json", assigns: "user")

      user ->
        user
    end

    case GetTransaction.run(id) do
      transaction = %Transaction{} ->
        conn
        |> put_status(:ok)
        |> render("show.json", transaction: transaction)

      nil ->
        conn
        |> put_status(:not_found)
        |> render(CurrencyConverterWeb.ErrorView, "404.json", assigns: "transaction")
    end
  end

  def create(conn, %{"transaction" => transaction_params, "user_id" => user_id}) do
    user = GetUser.run(user_id)

    case user do
      nil ->
        conn
        |> put_status(:not_found)
        |> render(CurrencyConverterWeb.ErrorView, "404.json", assigns: "user")

      user ->
        user
    end

    case Converter.run(
           transaction_params["origin_currency"],
           transaction_params["origin_amount"],
           transaction_params["destination_currency"]
         ) do
      {:ok, rate, destination_amount} ->
        {:ok, transaction} =
          NewTransaction.run(
            transaction_params
            |> Map.merge(%{
              "user_id" => user.id,
              "rate" => rate,
              "destination_amount" => destination_amount
            })
          )

        conn
        |> put_status(:created)
        |> render("show.json", transaction: transaction)

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: reason})
    end
  end
end
