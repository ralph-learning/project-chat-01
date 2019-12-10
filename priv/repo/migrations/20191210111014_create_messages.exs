defmodule ChatProject.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :message, :text
      add :user_id, references(:users, on_delete: :delete_all),
        null: false

      timestamps()
    end

    create index(:messages, [:user_id])
  end
end
