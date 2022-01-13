defmodule CurrencyConverter.Transaction.NewTransaction do
  alias CurrencyConverter.Repo
  alias CurrencyConverter.Transaction

  def run(attrs \\ %{}) do
    IO.inspect("------------")
    IO.inspect(attrs)
    IO.inspect("------------")
    # %Transaction{}
    # |> Transaction.changeset(attrs)
    # |> Repo.insert()
  end
end
