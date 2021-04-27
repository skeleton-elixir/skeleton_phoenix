defmodule Skeleton.App.Controller do
  @behaviour Skeleton.Phoenix.Controller

  defmacro __using__(_) do
    quote do
      use Skeleton.Phoenix.Controller
    end
  end

  def is_authenticated(conn), do: conn.private[:current_user]

  def fallback(conn) do
    conn
  end
end
