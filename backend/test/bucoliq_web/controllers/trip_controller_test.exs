defmodule BucoliqWeb.TripControllerTest do
  use BucoliqWeb.ConnCase

  test "GET /api/trips", %{conn: conn} do
    conn = get(conn, "/api/trips")
    assert %{"trips" => []} = json_response(conn, 200)

    create_trip()
    conn = get(conn, "/api/trips")

    assert %{
             "trips" => [
               %{
                 "name" => "test",
                 "start_time" => "2019-01-01T00:00:00Z",
                 "end_time" => "2019-01-01T00:00:00Z",
                 "description" => nil
               }
             ]
           } = json_response(conn, 200)
  end

  test "GET /api/trips/:id", %{conn: conn} do
    {:ok, trip} = create_trip()
    conn = get(conn, "/api/trips/#{trip.id}")

    assert %{
             "trip" => %{
               "name" => "test",
               "start_time" => "2019-01-01T00:00:00Z",
               "end_time" => "2019-01-01T00:00:00Z",
               "description" => nil
             }
           } = json_response(conn, 200)
  end

  test "POST /api/trips", %{conn: conn} do
    conn =
      post(conn, "/api/trips", %{
        "trip" => %{
          "name" => "test",
          "start_time" => "2019-01-01T00:00:00Z",
          "end_time" => "2019-01-01T00:00:00Z",
          "description" => nil
        }
      })

    assert %{
             "trip" => %{
               "id" => id,
               "name" => "test",
               "start_time" => "2019-01-01T00:00:00Z",
               "end_time" => "2019-01-01T00:00:00Z",
               "description" => nil
             }
           } = json_response(conn, 201)

    assert id != nil
  end

  test "PUT /api/trips/:id", %{conn: conn} do
    {:ok, trip} = create_trip()

    conn =
      put(conn, "/api/trips/#{trip.id}", %{
        "trip" => %{
          "name" => "testing",
          "start_time" => "2019-01-01T00:00:00Z",
          "end_time" => "2019-01-01T00:00:01Z",
          "description" => "hey, big man, let me hold a dollar."
        }
      })

    assert %{
             "trip" => %{
               "id" => id,
               "name" => "testing",
               "start_time" => "2019-01-01T00:00:00Z",
               "end_time" => "2019-01-01T00:00:01Z",
               "description" => "hey, big man, let me hold a dollar."
             }
           } = json_response(conn, 200)
  end

  test "DELETE /api/trips/:id", %{conn: conn} do
    {:ok, trip} = create_trip()

    conn = delete(conn, "/api/trips/#{trip.id}")

    assert %{
             "trip" => %{
               "id" => id,
               "name" => "test",
               "start_time" => "2019-01-01T00:00:00Z",
               "end_time" => "2019-01-01T00:00:00Z",
               "description" => nil
             }
           } = json_response(conn, 200)

    assert Bucoliq.Repo.aggregate(Bucoliq.Trip, :count, :id) == 0
  end

  defp create_trip do
    {:ok, start_time, _} = DateTime.from_iso8601("2019-01-01T00:00:00Z")
    {:ok, end_time, _} = DateTime.from_iso8601("2019-01-01T00:00:00Z")

    trip = %Bucoliq.Trip{
      name: "test",
      start_time: start_time,
      end_time: end_time
    }

    trip_changeset = Bucoliq.Trip.changeset(trip, %{})
    Bucoliq.Repo.insert(trip_changeset)
  end
end
