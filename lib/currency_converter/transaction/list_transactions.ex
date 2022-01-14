defmodule CurrencyConverter.Transaction.ListTransactions do
  @moduledoc """
  Get all transactions
  """

  alias CurrencyConverter.Repo
  alias CurrencyConverter.Transaction

  def run do
    Repo.all(Transaction)
  end
end
