defmodule CurrencyConverter.Accounts.ListUsers do
  @moduledoc """
  Get all users
  """

  alias CurrencyConverter.Accounts.User
  alias CurrencyConverter.Repo

  def run do
    Repo.all(User)
  end
end
