defmodule CurrencyConverter.Accounts.GetUser do
  alias CurrencyConverter.Repo
  alias CurrencyConverter.Accounts.User

  def run(id) do
    Repo.get!(User, id)
  end
end
