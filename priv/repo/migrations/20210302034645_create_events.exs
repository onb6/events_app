defmodule EventsApp.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :event_name, :string, null: false
      add :date, :date, null: false
      add :time, :time, null: false
      add :description, :string, null: false, default: ""
      add :user_id, references(:users), null: false

      timestamps()
    end

  end
end
