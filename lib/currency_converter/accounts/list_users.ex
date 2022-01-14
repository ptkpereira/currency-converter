defmodule CurrencyConverter.Accounts.ListUsers do
  @moduledoc """
  Get all users
  """

  alias CurrencyConverter.Repo
  alias CurrencyConverter.Accounts.User

  def run do
    Repo.all(User)
  end
end
