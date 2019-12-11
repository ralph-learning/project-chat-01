defmodule ChatProjectWeb.LayoutView do
  use ChatProjectWeb, :view

  def current_user(conn) do
    conn
    |> Plug.Conn.get_session(:user_id)
    |> IO.inspect
    |> case do
      nil -> false
      _id -> true
    end
  end

  def logged_in?(conn), do: !!current_user(conn)
end
