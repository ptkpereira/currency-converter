defmodule CurrencyConverterWeb.FallbackController do
  use CurrencyConverterWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    errors = translate_errors(changeset)

    conn
    |> put_status(:unprocessable_entity)
    |> json(%{errors: errors})
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> json(%{error: "not found"})
  end

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(
      changeset,
      &CurrencyConverterWeb.ErrorHelpers.translate_error/1
    )
  end
end
