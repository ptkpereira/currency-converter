defmodule CurrencyConverterWeb.ErrorView do
  use CurrencyConverterWeb, :view

  def render("404.json", %{assigns: assigns}) do
    %{errors: %{detail: "#{assigns} not found"}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal server error"}}
  end

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
