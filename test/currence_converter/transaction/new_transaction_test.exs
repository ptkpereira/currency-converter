defmodule CurrencyConverter.Transaction.NewTransactionTest do
  @moduledoc false

  use CurrencyConverter.DataCase, async: true

  alias CurrencyConverter.Accounts.NewUser
  alias CurrencyConverter.Transaction
  alias CurrencyConverter.Transaction.NewTransaction

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

      params = %{
        "origin_currency" => "BRL",
        "origin_amount" => 42,
        "destination_currency" => "USD",
        "rate" => 0.1806714,
        "user_id" => user.id
      }

      assert {:ok, %Transaction{} = transaction} = NewTransaction.run(params)

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

    test "returns error when params are invalid" do
      user = fixture()

      params = %{
        "origin_currency" => "",
        "origin_amount" => 42,
        "destination_currency" => "USD",
        "rate" => 0.1806714,
        "user_id" => user.id
      }

      assert {:error, %Ecto.Changeset{}} = NewTransaction.run(params)
    end
  end
end
