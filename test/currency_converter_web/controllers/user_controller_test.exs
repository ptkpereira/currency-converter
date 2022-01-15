defmodule CurrencyConverterWeb.UserControllerTest do
  use CurrencyConverterWeb.ConnCase

  import CurrencyConverter.Factory

  describe "index" do
    test "returns 200 with a list of users", %{conn: conn} do
      insert(:user, name: "Jane Smith")

      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["users"] != []
    end
  end

  describe "show" do
    test "returns 200 with a single user", %{conn: conn} do
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

  describe "create" do
    test "returns 201 when user is created successfully", %{conn: conn} do
      params = %{"name" => "Jane Smith"}

      conn = post(conn, Routes.user_path(conn, :create), user: params)
      assert json_response(conn, 201)
    end

    test "returns 422 when name is invalid", %{conn: conn} do
      params = %{"name" => ""}

      conn = post(conn, Routes.user_path(conn, :create), user: params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
