defmodule CurrencyConverterWeb.UserController do
  @moduledoc """
  User controller
  """

  use CurrencyConverterWeb, :controller

  alias CurrencyConverter.Accounts.{GetUser, ListUsers, NewUser, User}

  action_fallback(CurrencyConverterWeb.FallbackController)

  def index(conn, _params) do
    users = ListUsers.run()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    case GetUser.run(id) do
      user = %User{} ->
        conn
        |> put_status(:ok)
        |> render("show.json", user: user)

      nil ->
        conn
        |> put_status(:not_found)
        |> render(CurrencyConverterWeb.ErrorView, "404.json", assigns: "user")
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- NewUser.run(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end
end
