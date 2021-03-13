defmodule EventsApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration
  alias EventsApp.Photos

  defmodule Inject do
    def photo(name) do
      photos = Application.app_dir(:events_app, "priv/photos")
      path = Path.join(photos, name)
      {:ok, hash} = Photos.save_photo(name, path)
      hash
    end
  end

  def change do
    default_photo = Inject.photo("default.jpeg")
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, unique: true, null: false
      add :photo_hash, :text, null: false, default: default_photo

      timestamps()
    end
  end
end
