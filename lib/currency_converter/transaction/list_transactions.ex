defmodule CurrencyConverter.Transaction.ListTransactions do
  @moduledoc """
  Get all transactions
  """

  import Ecto.Query, only: [from: 2]

  alias CurrencyConverter.Repo
  alias CurrencyConverter.Transaction

  def run(user) do
    Repo.all(from t in Transaction, where: t.user_id == ^user.id)
  end
end
