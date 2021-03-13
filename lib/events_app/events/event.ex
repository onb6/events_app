defmodule EventsApp.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :date, :date
    field :description, :string
    field :event_name, :string
    field :time, :time

    belongs_to :user, EventsApp.Users.User
    has_many :comments, EventsApp.Comments.Comment
    has_many :updates, EventsApp.Updates.Update
    has_many :invites, EventsApp.Invites.Invite

    field :yes, :integer, virtual: true
    field :no, :integer, virtual: true
    field :maybe, :integer, virtual: true
    field :nr, :integer, virtual: true

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:event_name, :date, :time, :description, :user_id])
    |> validate_required([:event_name, :date, :time, :description, :user_id])
  end
end
