defmodule CurrencyConverter.Accounts.GetUser do
  @moduledoc """
  Get user
  """

  alias CurrencyConverter.Accounts.User
  alias CurrencyConverter.Repo

  def run(id) do
    Repo.get!(User, id)
  end
end
