defmodule Skeleton.App.UserPermission do
  use Skeleton.App.Permission

  def context(conn, _context) do
    %{user: conn.assigns[:user]}
  end

  def check(:can_update, context) do
    context.current_user && context.current_user.id == context.user.id
  end

  def permit(:can_update, context) do
    if check(:can_update, context) && context.current_user.admin do
      context.params
    else
      unpermit(context.params, ["admin"])
    end
  end

  def preload_data(context, permissions) do
    [user] = do_preload(context, permissions, [context.user])
    %{context | user: user}
  end

  def preload_data(context, permissions, users) do
    do_preload(context, permissions, users)
  end

  defp do_preload(_context, _permissions, users) do
    # ids = Enum.map(users, & &1.id)
    users
  end
end
