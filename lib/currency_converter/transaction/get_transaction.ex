defmodule CurrencyConverter.Transaction.GetTransaction do
  @moduledoc """
  Get transaction
  """

  alias CurrencyConverter.Repo
  alias CurrencyConverter.Transaction

  def run(id) do
    Repo.get!(Transaction, id)
  end
end
