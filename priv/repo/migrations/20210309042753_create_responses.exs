defmodule EventsApp.Repo.Migrations.CreateResponses do
  use Ecto.Migration

  def change do
    create table(:responses) do
      add :response, :integer, null: false, default: -1
      add :event_id, references(:events, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:responses, [:event_id])
    create index(:responses, [:user_id])
  end
end
