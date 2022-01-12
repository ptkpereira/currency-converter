defmodule CurrencyConverter.NewUser do
  alias CurrencyConverter.{Repo, User}

  def run(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
