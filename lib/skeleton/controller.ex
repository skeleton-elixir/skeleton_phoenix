defmodule Skeleton.Phoenix.Controller do
  import Plug.Conn

  alias Skeleton.Phoenix.Config, as: Config

  # Callbacks

  @callback is_authenticated(Plug.Conn.t()) :: Boolean.t()
  @callback fallback(Plug.Conn.t()) :: Plug.Conn.t()

  defmacro __using__(_) do
    alias Skeleton.Phoenix.Controller

    quote do
      # Ensure authenticated

      def ensure_authenticated(%{halted: true} = conn), do: conn
      def ensure_authenticated(conn), do: Controller.do_ensure_authenticated(conn)

      # Ensure not authenticated

      def ensure_not_authenticated(%{halted: true} = conn), do: conn
      def ensure_not_authenticated(conn), do: Controller.do_ensure_not_authenticated(conn)

      # Resolve

      def resolve(%{halted: true} = conn, _), do: Config.controller().fallback(conn)
      def resolve(conn, callback), do: callback.(conn)
    end
  end

  # Do ensure authenticated

  def do_ensure_authenticated(conn) do
    if Config.controller().is_authenticated(conn) do
      conn
    else
      forbidden(conn)
    end
  end

  # Do ensure not authenticated

  def do_ensure_not_authenticated(conn) do
    if Config.controller().is_authenticated(conn) do
      forbidden(conn)
    else
      conn
    end
  end

  # Return unauthorized

  def unauthorized(conn) do
    conn |> put_status(:unauthorized) |> halt()
  end

  def forbidden(conn) do
    conn |> put_status(:forbidden) |> halt()
  end
end
