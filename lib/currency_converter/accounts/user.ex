defmodule CurrencyConverter.Accounts.User do
  @moduledoc """
  User schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias CurrencyConverter.Transaction

  schema "users" do
    field :name, :string
    has_many :transactions, Transaction

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
