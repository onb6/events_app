defmodule EventsAppWeb.ResponseControllerTest do
  use EventsAppWeb.ConnCase

  alias EventsApp.Responses

  @create_attrs %{response: 42}
  @update_attrs %{response: 43}
  @invalid_attrs %{response: nil}

  def fixture(:response) do
    {:ok, response} = Responses.create_response(@create_attrs)
    response
  end

  describe "index" do
    test "lists all responses", %{conn: conn} do
      conn = get(conn, Routes.response_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Responses"
    end
  end

  describe "new response" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.response_path(conn, :new))
      assert html_response(conn, 200) =~ "New Response"
    end
  end

  describe "create response" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.response_path(conn, :create), response: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.response_path(conn, :show, id)

      conn = get(conn, Routes.response_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Response"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.response_path(conn, :create), response: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Response"
    end
  end

  describe "edit response" do
    setup [:create_response]

    test "renders form for editing chosen response", %{conn: conn, response: response} do
      conn = get(conn, Routes.response_path(conn, :edit, response))
      assert html_response(conn, 200) =~ "Edit Response"
    end
  end

  describe "update response" do
    setup [:create_response]

    test "redirects when data is valid", %{conn: conn, response: response} do
      conn = put(conn, Routes.response_path(conn, :update, response), response: @update_attrs)
      assert redirected_to(conn) == Routes.response_path(conn, :show, response)

      conn = get(conn, Routes.response_path(conn, :show, response))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, response: response} do
      conn = put(conn, Routes.response_path(conn, :update, response), response: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Response"
    end
  end

  describe "delete response" do
    setup [:create_response]

    test "deletes chosen response", %{conn: conn, response: response} do
      conn = delete(conn, Routes.response_path(conn, :delete, response))
      assert redirected_to(conn) == Routes.response_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.response_path(conn, :show, response))
      end
    end
  end

  defp create_response(_) do
    response = fixture(:response)
    {:ok, response: response}
  end
end
