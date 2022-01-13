defmodule CurrencyConverter.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :origin_currency, :string
      add :origin_amount, :decimal
      add :destination_currency, :string
      add :rate, :decimal
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:transactions, [:user_id])
  end
end
