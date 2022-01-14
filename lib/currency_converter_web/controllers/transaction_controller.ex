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

  @currencies ["BRL", "USD", "JPY", "EUR"]

  def index(conn, _params) do
    transactions = ListTransactions.run()
    render(conn, "index.json", transactions: transactions)
  end

  def show(conn, %{"id" => id}) do
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

    check_params(conn, transaction_params)

    {rate, destination_amount} =
      ExchangeRatesApi.get_rates()
      |> Converter.run(
        transaction_params["origin_currency"],
        transaction_params["origin_amount"],
        transaction_params["destination_currency"]
      )

    case NewTransaction.run(
           transaction_params
           |> Map.merge(%{
             "user_id" => user.id,
             "rate" => rate,
             "destination_amount" => destination_amount
           })
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

  defp check_params(conn, params) do
    cond do
      params["origin_currency"] not in @currencies ->
        conn
        |> put_status(:bad_request)
        |> json(%{status: "origin currency not found"})

      is_binary(params["origin_amount"]) ->
        conn
        |> put_status(:bad_request)
        |> json(%{status: "origin amount not found"})

      params["destination_currency"] not in @currencies ->
        conn
        |> put_status(:bad_request)
        |> json(%{status: "destination currency not found"})

      is_binary(params["origin_currency"]) and is_binary(params["destination_currency"]) and
          is_number(params["origin_amount"]) ->
        params

      true ->
        conn
        |> put_status(:bad_request)
        |> json(%{status: "error in params"})
    end
  end
end
