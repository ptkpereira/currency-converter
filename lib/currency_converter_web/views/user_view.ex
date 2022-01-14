defmodule CurrencyConverterWeb.UserView do
  use CurrencyConverterWeb, :view

  def render("index.json", %{users: users}) do
    %{users: render_many(users, __MODULE__, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, __MODULE__, "user.json")}
  end

  def render("user.json", %{user: user}) do
    user
    |> Map.from_struct()
    |> Map.take([:id, :name, :inserted_at, :updated_at])
  end
end
