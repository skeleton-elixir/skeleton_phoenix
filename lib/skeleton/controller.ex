defmodule Skeleton.Phoenix.Controller do
  import Plug.Conn

  @callback is_authenticated(Plug.Conn.t()) :: Boolean.t()
  @callback fallback(Plug.Conn.t()) :: Plug.Conn.t()

  defmacro __using__(opts) do
    alias Skeleton.Phoenix.Controller

    quote do
      @controller unquote(opts[:controller]) || raise("Controller required")

      def ensure_authenticated(%{halted: true} = conn), do: conn
      def ensure_authenticated(conn), do: Controller.do_ensure_authenticated(@controller, conn)

      def ensure_not_authenticated(%{halted: true} = conn), do: conn
      def ensure_not_authenticated(conn), do: Controller.do_ensure_not_authenticated(@controller, conn)

      def resolve(%{halted: true} = conn, _), do: @controller.fallback(conn)
      def resolve(conn, callback), do: callback.(conn)
    end
  end

  # Do ensure authenticated

  def do_ensure_authenticated(controller, conn) do
    if controller.is_authenticated(conn) do
      conn
    else
      forbidden(conn)
    end
  end

  # Do ensure not authenticated

  def do_ensure_not_authenticated(controller, conn) do
    if controller.is_authenticated(conn) do
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
