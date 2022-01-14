defmodule CurrencyConverter.Accounts.NewUser do
  @moduledoc """
  Create user
  """

  alias CurrencyConverter.Accounts.User
  alias CurrencyConverter.Repo

  def run(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
