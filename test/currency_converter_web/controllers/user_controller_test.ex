defmodule CurrencyConverterWeb.UserControllerTest do
  use CurrencyConverterWeb.ConnCase

  alias CurrencyConverter.Accounts.{GetUser, ListUsers, NewUser, User}

  import CurrencyConverter.Factory

  describe "index" do
    test "list all users", %{conn: conn} do
      insert(:user, id: "1", name: "Jane Smith")

      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["users"] != []
    end
  end

  describe "show" do
    test "view one user", %{conn: conn} do
      insert(:user,
        id: 1,
        inserted_at: "2022-01-14T21:04:09",
        name: "Jane Smith",
        updated_at: "2022-01-14T21:04:09"
      )

      conn = get(conn, Routes.user_path(conn, :show, 1))

      assert %{
               "user" => %{
                 "id" => 1,
                 "inserted_at" => "2022-01-14T21:04:09",
                 "name" => "Jane Smith",
                 "updated_at" => "2022-01-14T21:04:09"
               }
             } = json_response(conn, 200)
    end
  end
end
