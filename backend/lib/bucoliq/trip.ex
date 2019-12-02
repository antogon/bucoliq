defmodule Bucoliq.Trip do
  @moduledoc """
  A Trip is a single outing that happens at a single point in time and
  has many points of interest in it.  This object will be the beginning of all
  adventures planned using Bucoliq.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "trips" do
    field :description, :string
    field :end_time, :utc_datetime
    field :name, :string
    field :start_time, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(trip, attrs) do
    trip
    |> cast(attrs, [:name, :start_time, :end_time, :description])
    |> validate_required([:name, :start_time, :end_time])
  end
end
