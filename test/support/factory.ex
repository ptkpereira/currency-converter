defmodule CurrencyConverter.Factory do
  @moduledoc """
  Factory for tests
  """

  use ExMachina.Ecto, repo: CurrencyConverter.Repo

  def user_factory do
    %CurrencyConverter.Accounts.User{
      name: "Jane Smith"
    }
  end

  def transaction_factory do
    %CurrencyConverter.Transaction{
      user_id: 1,
      origin_currency: "BRL",
      origin_amount: 42.00,
      destination_currency: "USD"
    }
  end
end
