defmodule CurrencyConverter.Accounts.NewUserTest do
  use CurrencyConverter.DataCase, async: true

  alias CurrencyConverter.Accounts.{NewUser, User}

  describe "run" do
    test "returns the user" do
      params = %{"name" => "Jane Smith"}

      assert {:ok, %User{} = user} = NewUser.run(params)
      assert user.name == "Jane Smith"
    end

    test "returns error when name is invalid" do
      params = %{"name" => ""}

      assert {:error, %Ecto.Changeset{}} = NewUser.run(params)
    end
  end
end
