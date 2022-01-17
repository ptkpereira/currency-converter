defmodule CurrencyConverter.Transaction.GetTransactionTest do
  @moduledoc false

  use CurrencyConverter.DataCase, async: true

  import CurrencyConverter.Factory

  alias CurrencyConverter.Accounts.NewUser
  alias CurrencyConverter.Transaction.GetTransaction

  @user_attrs %{
    name: "Jane Smith"
  }

  def fixture do
    {:ok, user} = NewUser.run(@user_attrs)
    user
  end

  describe "run" do
    test "returns the transaction" do
      user = fixture()

      insert(:transaction,
        id: 1,
        origin_currency: "BRL",
        origin_amount: 42,
        destination_currency: "USD",
        rate: 0.1806714,
        user_id: user.id
      )

      transaction = GetTransaction.run(1)

      assert %{
               "origin_currency" => transaction.origin_currency,
               "origin_amount" => transaction.origin_amount,
               "destination_currency" => transaction.destination_currency,
               "rate" => transaction.rate,
               "user_id" => transaction.user_id
             } ==
               %{
                 "origin_currency" => "BRL",
                 "origin_amount" => Decimal.new(42),
                 "destination_currency" => "USD",
                 "rate" => Decimal.from_float(0.1806714),
                 "user_id" => user.id
               }
    end
  end
end
