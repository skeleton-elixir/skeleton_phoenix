defmodule Skeleton.App.Permission do
  defmacro __using__(_) do
    quote do
      use Skeleton.Permission
      import Ecto.Query
      alias Skeleton.App.Repo
    end
  end

  def context(%Plug.Conn{} = conn) do
    %{
      current_user: conn.private[:current_user],
      resource: conn.assigns[:resource],
      source: conn.assigns[:source],
      params: conn.params
    }
  end
end
