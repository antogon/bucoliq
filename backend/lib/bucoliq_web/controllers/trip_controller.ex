defmodule BucoliqWeb.TripController do
  use BucoliqWeb, :controller

  def index(conn, params) do
    page = Bucoliq.Trip |> Bucoliq.Repo.paginate(params)
    render(conn, "index.json", %{page: page})
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.json", %{trip: Bucoliq.Trip |> Bucoliq.Repo.get(id)})
  end

  def create(conn, params) do
    trip_changeset = Bucoliq.Trip.changeset(%Bucoliq.Trip{}, Map.get(params, "trip"))

    case Bucoliq.Repo.insert(trip_changeset) do
      {:ok, trip} -> conn |> put_status(201) |> render("show.json", %{trip: trip})
      {:error, changeset} -> conn |> put_status(422) |> json(%{errors: format_errors(changeset)})
      _ -> conn |> put_status(500) |> json(%{errors: [:internal_server_error]})
    end
  end

  def update(conn, params) do
    trip_attributes = Map.get(params, "trip")
    trip = Bucoliq.Trip |> Bucoliq.Repo.get(Map.get(params, "id"))
    changeset = Bucoliq.Trip.changeset(trip, trip_attributes)

    case Bucoliq.Repo.update(changeset) do
      {:ok, trip} -> conn |> put_status(200) |> render("show.json", %{trip: trip})
      {:error, changeset} -> conn |> put_status(422) |> json(%{errors: format_errors(changeset)})
      _ -> conn |> put_status(500) |> json(%{errors: [:internal_server_error]})
    end
  end

  def delete(conn, %{"id" => id}) do
    trip = Bucoliq.Trip |> Bucoliq.Repo.get(id)

    case Bucoliq.Repo.delete(trip) do
      {:ok, trip} -> conn |> put_status(200) |> render("show.json", %{trip: trip})
      {:error, changeset} -> conn |> put_status(422) |> json(%{errors: format_errors(changeset)})
      _ -> conn |> put_status(500) |> json(%{errors: [:internal_server_error]})
    end
  end

  defp format_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
