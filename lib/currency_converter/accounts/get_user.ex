defmodule CurrencyConverter.GetUser do
  alias CurrencyConverter.{Repo, User}

  def run(id) do
    Repo.get!(User, id)
  end
end
