defmodule CurrencyConverter.ListUsers do
  alias CurrencyConverter.{Repo, User}

  def run do
    Repo.all(User)
  end
end
