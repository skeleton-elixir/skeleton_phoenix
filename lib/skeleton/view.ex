defmodule Skeleton.Phoenix.View do
  alias Skeleton.Permission.Config, as: PermConfig

  defmacro __using__(_) do
    alias Skeleton.Phoenix.View, as: Vw

    quote do
      # Preload permissions

      def preload_permissions(conn, items, permission_module, permission_names)
          when is_list(permission_names) do
        Vw.preload_permissions(conn, items, permission_module, permission_names)
      end

      def preload_permissions(conn, items, permission_module, permission_name) do
        Vw.preload_permissions(conn, items, permission_module, [permission_name])
      end

      # Check permissions

      def check_permission(conn, permission_module, permission_name) do
        Vw.check_permission(conn, permission_module, permission_name, %{})
      end

      def check_permission(conn, permission_module, permission_name, context) when is_map(context) do
        Vw.check_permission(conn, permission_module, permission_name, context)
      end

      def check_permission(conn, permission_module, permission_name, context) when is_list(context) do
        Vw.check_permission(conn, permission_module, permission_name, Enum.into(context, %{}))
      end
    end
  end

  # Preload permissions

  def preload_permissions(conn, items, permission_module, permission_names) do
    context = PermConfig.permission().context(conn)
    permission_module.preload(context, permission_names, items)
  end

  # Check permission

  def check_permission(conn, permission_module, permission_name, context) do
    context =
      conn
      |> PermConfig.permission().context()
      |> Map.merge(context)

    permission_module.check(permission_name, context)
  end
end
