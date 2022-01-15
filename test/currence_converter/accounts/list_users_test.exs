defmodule CurrencyConverter.Accounts.ListUsersTest do
  use CurrencyConverter.DataCase, async: true

  import CurrencyConverter.Factory

  alias CurrencyConverter.Accounts.ListUsers

  describe "run" do
    test "returns the users" do
      insert(:user, name: "Jane Smith")
      insert(:user, name: "John Doe")

      users = ListUsers.run()
      assert is_list(users)
      assert length(users) == 2
      assert Enum.map(users, fn user -> user.name end) == ["Jane Smith", "John Doe"]
    end
  end
end
