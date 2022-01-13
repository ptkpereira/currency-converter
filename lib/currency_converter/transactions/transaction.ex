defmodule CurrencyConverter.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :destination_currency, :string
    field :origin_amount, :decimal
    field :origin_currency, :string
    field :rate, :decimal
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:origin_currency, :origin_amount, :destination_currency, :rate, :user_id])
    |> validate_required([
      :origin_currency,
      :origin_amount,
      :destination_currency,
      :rate,
      :user_id
    ])
  end
end
