defmodule Skeleton.AppWeb.Controller do
  @behaviour Skeleton.Phoenix.Controller

  defmacro __using__(_) do
    quote do
      use Skeleton.Phoenix.Controller, controller: Skeleton.AppWeb.Controller
    end
  end

  def is_authenticated(conn), do: conn.private[:current_user]

  def fallback(conn) do
    conn
  end
end
