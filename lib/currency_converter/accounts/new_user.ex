defmodule CurrencyConverter.Accounts.NewUser do
  alias CurrencyConverter.Repo
  alias CurrencyConverter.Accounts.User

  def run(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
