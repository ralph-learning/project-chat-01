defmodule ChatProjectWeb.RoomChannel do
  use Phoenix.Channel

  alias ChatProject.Chat
  alias ChatProject.Repo
  alias ChatProject.Accounts.User

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"user_id" => user_id, "body" => body}, socket) do
    user = Repo.get(User, user_id)

    case Chat.create_message(user, %{ message: body }) do
      {:ok, message} ->
        broadcast! socket, "new_msg", %{body: message.message, name: user.name}
        {:reply, :ok, socket}

      {:error, changeset} ->
        {:reply, {:error, %{reasons: changeset}}, socket}
    end
  end
end
