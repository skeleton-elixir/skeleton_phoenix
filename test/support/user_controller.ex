defmodule Skeleton.Phoenix.UserController do
  use Skeleton.Phoenix.Controller
  alias Skeleton.Phoenix.UserPermission

  def update(conn) do
    conn
    |> ensure_authenticated()
    |> check_permission(UserPermission, :can_update)
    |> permit_params(UserPermission, :can_update)
    |> resolve(fn conn ->
      conn
    end)
  end

  def unauthenticated_update(conn) do
    conn
    |> ensure_not_authenticated()
    |> resolve(fn conn ->
      conn
    end)
  end
end
