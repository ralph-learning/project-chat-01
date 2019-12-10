defmodule ChatProject.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChatProject.Accounts.User

  schema "messages" do
    field :message, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
