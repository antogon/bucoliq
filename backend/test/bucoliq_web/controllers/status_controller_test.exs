defmodule BucoliqWeb.StatusControllerTest do
  use BucoliqWeb.ConnCase

  test "GET /api/status", %{conn: conn} do
    conn = get(conn, "/api/status")
    assert json_response(conn, 200) == %{"status" => "ok"}
  end
end
