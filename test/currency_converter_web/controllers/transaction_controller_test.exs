defmodule CurrencyConverterWeb.TransactionControllerTest do
  use CurrencyConverterWeb.ConnCase

  import CurrencyConverter.Factory

  @user_attrs %{
    name: "Jane Smith"
  }

  def fixture() do
    {:ok, user} = CurrencyConverter.Accounts.NewUser.run(@user_attrs)
    user
  end

  describe "index" do
    test "returns 200 with a list of transactions by user", %{conn: conn} do
      user = fixture()

      insert(:transaction,
        origin_currency: "BRL",
        origin_amount: 42.00,
        destination_currency: "USD",
        rate: 1.222,
        user_id: user.id
      )

      conn = get(conn, Routes.user_transaction_path(conn, :index, user.id))

      assert json_response(conn, 200)["transactions"] != []
    end
  end

  describe "show" do
    test "returns 200 with a single transaction of a user", %{conn: conn} do
      user2 = fixture()

      insert(:transaction,
        id: 1,
        origin_currency: "BRL",
        origin_amount: 42,
        destination_currency: "USD",
        rate: 0.18067,
        user_id: user2.id
      )

      conn = get(conn, Routes.user_transaction_path(conn, :show, user2.id, 1))
      json = json_response(conn, 200)["transaction"]

      assert json == %{
               "id" => 1,
               "origin_currency" => "BRL",
               "origin_amount" => "42",
               "destination_currency" => "USD",
               "rate" => "0.18067",
               "destination_amount" => "7.59",
               "user_id" => user2.id,
               "date_time" => json["date_time"]
             }
    end
  end

  # describe "create" do
  #   test "returns 201 when transaction is created successfully", %{conn: conn} do
  #     params = %{"name" => "Jane Smith"}

  #     conn = post(conn, Routes.transaction_path(conn, :create), transaction: params)
  #     assert json_response(conn, 201)
  #   end

  #   test "returns 422 when name is invalid", %{conn: conn} do
  #     params = %{"name" => ""}

  #     conn = post(conn, Routes.transaction_path(conn, :create), transaction: params)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end
end
