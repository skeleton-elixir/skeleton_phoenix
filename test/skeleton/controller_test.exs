defmodule Skeleton.Phoenix.ControllerTest do
  use Skeleton.App.TestCase
  import Plug.Conn
  alias Plug.Conn
  alias Skeleton.App.{User, UserController}

  setup context do
    conn = %Conn{}
    Map.put(context, :conn, conn)
  end

  describe "ensure the user is authenticated" do
    test "when isn't authenticated", context do
      conn = UserController.update(context.conn)
      assert conn.halted
      assert conn.status == 403
    end

    test "when is authenticated", context do
      user = %User{id: 1}

      conn =
        context.conn
        |> put_private(:current_user, user)
        |> assign(:user, user)
        |> UserController.update()

      refute conn.halted
      refute conn.status
    end
  end

  describe "ensure the user is not authenticated" do
    test "when isn't authenticated", context do
      conn = UserController.unauthenticated_update(context.conn)
      refute conn.halted
      refute conn.status
    end

    test "when is authenticated", context do
      user = %User{id: 1}

      conn =
        context.conn
        |> put_private(:current_user, user)
        |> assign(:user, user)
        |> UserController.unauthenticated_update()

      assert conn.halted
      assert conn.status == 403
    end
  end

  describe "resoving controller" do
    test "when it's valid", context do
      user = %User{id: 1}

      conn =
        context.conn
        |> put_private(:current_user, user)
        |> assign(:user, user)
        |> UserController.update()

      refute conn.halted
      refute conn.status
    end

    test "when it's not valid", context do
      conn = UserController.update(context.conn)
      assert conn.halted
      assert conn.status == 403
    end
  end
end
