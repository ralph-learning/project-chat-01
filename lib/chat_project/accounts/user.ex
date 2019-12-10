defmodule ChatProject.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChatProject.Accounts.Credential
  alias ChatProject.Chat.Message

  schema "users" do
    field :name, :string
    field :username, :string
    has_one :credential, Credential
    has_many :message, Message

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> unique_constraint(:username)
  end
end
