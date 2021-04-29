defmodule Skeleton.AppWeb.UserController do
  use Skeleton.AppWeb, :controller

  def update(conn) do
    conn
    |> ensure_authenticated()
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
