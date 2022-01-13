defmodule CurrencyConverterWeb.UserView do
  use CurrencyConverterWeb, :view

  def render("index.json", %{users: users}) do
    %{users: render_many(users, __MODULE__, "show.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, __MODULE__, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      created_at: user.inserted_at
    }
  end
end
