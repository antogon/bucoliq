defmodule BucoliqWeb.PageControllerTest do
  use BucoliqWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Bucoliq API Server is up and running"
  end
end
