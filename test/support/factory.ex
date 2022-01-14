defmodule CurrencyConverter.Factory do
  use ExMachina.Ecto, repo: CurrencyConverter.Repo

  def user_factory do
    %CurrencyConverter.Accounts.User{
      id: 1,
      inserted_at: "2022-01-14T21:04:09",
      name: "Jane Smith",
      updated_at: "2022-01-14T21:04:09"
    }
  end
end
