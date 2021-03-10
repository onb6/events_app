defmodule EventsApp.Updates.Update do
  use Ecto.Schema
  import Ecto.Changeset

  schema "updates" do
    field :body, :string
    belongs_to :event, EventsApp.Events.Event

    timestamps()
  end

  @doc false
  def changeset(update, attrs) do
    update
    |> cast(attrs, [:body, :event_id])
    |> validate_required([:body, :event_id])
  end
end
