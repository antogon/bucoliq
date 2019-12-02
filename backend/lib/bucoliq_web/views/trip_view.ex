defmodule BucoliqWeb.TripView do
  use BucoliqWeb, :view

  def render("index.json", %{page: page}) do
    %{
      trips: render_many(page.entries, BucoliqWeb.TripView, "trip.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_pages: page.total_pages,
      total_entries: page.total_entries
    }
  end

  def render("show.json", %{trip: trip}) do
    %{trip: render_one(trip, BucoliqWeb.TripView, "trip.json")}
  end

  def render("trip.json", %{trip: trip}) do
    %{
      id: trip.id,
      name: trip.name,
      start_time: trip.start_time,
      end_time: trip.end_time,
      description: trip.description
    }
  end
end
