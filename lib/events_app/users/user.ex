defmodule EventsApp.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  defmodule Inject do
    def photo(name) do
      photos = Application.app_dir(:events_app, "priv/photos")
      path = Path.join(photos, name)
      {:ok, hash} = EventsApp.Photos.save_photo(name, path)
      hash
    end
  end

  default_photo = Inject.photo("default.jpeg")

  schema "users" do
    field :email, :string
    field :name, :string
    field :photo_hash, :string, default: default_photo
    has_many :events, EventsApp.Events.Event
    has_many :comments, EventsApp.Comments.Comment
    has_many :invites, EventsApp.Invites.Invite

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :photo_hash])
    |> validate_required([:name, :email])
    |> unsafe_validate_unique([:email], EventsApp.Repo)
  end
end
