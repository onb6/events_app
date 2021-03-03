defmodule EventsApp.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :date, :date
    field :description, :string
    field :event_name, :string
    field :time, :time

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:event_name, :date, :time, :description])
    |> validate_required([:event_name, :date, :time, :description])
  end
end
