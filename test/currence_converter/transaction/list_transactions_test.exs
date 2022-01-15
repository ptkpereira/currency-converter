defmodule CurrencyConverter.Transaction.ListTransactionsTest do
  use CurrencyConverter.DataCase, async: true

  import CurrencyConverter.Factory

  alias CurrencyConverter.Accounts.NewUser
  alias CurrencyConverter.Transaction.ListTransactions

  @user_attrs %{
    name: "Jane Smith"
  }

  def fixture do
    {:ok, user} = NewUser.run(@user_attrs)
    user
  end

  describe "run" do
    test "returns the transactions" do
      user = fixture()

      insert(:transaction,
        origin_currency: "BRL",
        origin_amount: 42,
        destination_currency: "USD",
        rate: 0.1806714,
        user_id: user.id
      )

      insert(:transaction,
        origin_currency: "EUR",
        origin_amount: 42,
        destination_currency: "JPY",
        rate: 130.411996,
        user_id: user.id
      )

      transactions = ListTransactions.run(user)
      assert is_list(transactions)
      assert length(transactions) == 2

      assert Enum.map(transactions, fn transaction ->
               %{
                 "origin_currency" => transaction.origin_currency,
                 "origin_amount" => transaction.origin_amount,
                 "destination_currency" => transaction.destination_currency,
                 "rate" => transaction.rate,
                 "user_id" => transaction.user_id
               }
             end) == [
               %{
                 "origin_currency" => "BRL",
                 "origin_amount" => Decimal.new(42),
                 "destination_currency" => "USD",
                 "rate" => Decimal.from_float(0.1806714),
                 "user_id" => user.id
               },
               %{
                 "origin_currency" => "EUR",
                 "origin_amount" => Decimal.new(42),
                 "destination_currency" => "JPY",
                 "rate" => Decimal.from_float(130.411996),
                 "user_id" => user.id
               }
             ]
    end
  end
end
