defmodule EventsApp.Repo.Migrations.CreateInvites do
  use Ecto.Migration

  def change do
    create table(:invites) do
      add :response, :integer, null: false, defaults: -1
      add :event_id, references(:events, on_delete: :nothing), null: false
      add :email, :string, null: false

      timestamps()
    end

    create index(:invites, [:event_id, :email], unique: true)
  end
end
