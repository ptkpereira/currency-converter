defmodule CurrencyConverter.Transaction.NewTransaction do
  @moduledoc """
  Create transaction
  """

  alias CurrencyConverter.Repo
  alias CurrencyConverter.Transaction

  def run(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end
end
