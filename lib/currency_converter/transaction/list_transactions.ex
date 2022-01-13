defmodule CurrencyConverter.Transaction.ListTransactions do
  alias CurrencyConverter.Repo
  alias CurrencyConverter.Transaction

  def run do
    Repo.all(Transaction)
  end
end
