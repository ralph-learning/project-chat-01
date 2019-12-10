defmodule ChatProject.Repo.Migrations.CreateCredentials do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add :password, :string
      add :email, :string
      add :user_id, references(:users, on_delete: :delete_all),
        null: false

      timestamps()
    end

    create index(:credentials, [:user_id])
  end
end
