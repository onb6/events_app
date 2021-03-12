defmodule EventsApp.Invites.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invites" do
    field :response, :integer
    belongs_to :event, EventsApp.Events.Event
    belongs_to :user, EventsApp.Users.User, foreign_key: :email, references: :email, type: :string
    
    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:response, :email, :event_id])
    |> validate_required([:response, :email, :event_id])
  end
end
