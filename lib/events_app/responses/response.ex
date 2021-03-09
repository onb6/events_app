defmodule EventsApp.Responses.Response do
  use Ecto.Schema
  import Ecto.Changeset

  schema "responses" do
    field :response, :integer
    belongs_to :event, EventsApp.Events.Event
    belongs_to :user, EventsApp.Users.User

    timestamps()
  end

  @doc false
  def changeset(response, attrs) do
    response
    |> cast(attrs, [:response, :event_id, :user_id])
    |> validate_required([:response, :event_id, :user_id])
  end
end
