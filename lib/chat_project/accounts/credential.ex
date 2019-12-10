defmodule ChatProject.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChatProject.Accounts.User

  schema "credentials" do
    field :email, :string
    field :password, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:password, :email])
    |> validate_required([:password, :email])
  end
end
