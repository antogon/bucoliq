defmodule BucoliqWeb.StatusController do
  use BucoliqWeb, :controller

  def index(conn, _params) do
    json(conn, %{status: "ok"})
  end
end
