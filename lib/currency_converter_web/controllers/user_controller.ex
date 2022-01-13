defmodule CurrencyConverterWeb.UserController do
  use CurrencyConverterWeb, :controller

  alias CurrencyConverter.Accounts.{ListUsers, GetUser, NewUser}

  def index(conn, _params) do
    users = ListUsers.run()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = GetUser.run(id)
    render(conn, "show.json", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    case NewUser.run(user_params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("show.json", user: user)

      {:error, _} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{status: "unprocessable entity"})
    end
  end
end
