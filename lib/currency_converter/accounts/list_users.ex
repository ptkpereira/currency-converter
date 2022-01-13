defmodule CurrencyConverter.Accounts.ListUsers do
  alias CurrencyConverter.Repo
  alias CurrencyConverter.Accounts.User

  def run do
    Repo.all(User)
  end
end
