defmodule CurrencyConverter.Accounts.GetUserTest do
  @moduledoc false

  use CurrencyConverter.DataCase, async: true

  import CurrencyConverter.Factory

  alias CurrencyConverter.Accounts.GetUser

  describe "run" do
    test "returns the user" do
      insert(:user, id: 1, name: "Jane Smith")

      user = GetUser.run(1)
      assert user.name == "Jane Smith"
    end
  end
end
