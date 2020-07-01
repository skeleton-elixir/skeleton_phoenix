defmodule Skeleton.ControllerTest do
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
      assert conn.status == 401
    end

    test "when is authenticated", context do
      conn =
        context.conn
        |> put_private(:current_user, %User{id: 123})
        |> assign(:resource, %User{id: 123})
        |> UserController.update()

      refute conn.halted
      assert conn.status == 200
    end
  end

  describe "ensure the user is not authenticated" do
    test "when isn't authenticated", context do
      conn = UserController.unauthenticated_update(context.conn)
      refute conn.halted
      assert conn.status == 200
    end

    test "when is authenticated", context do
      conn =
        context.conn
        |> put_private(:current_user, %User{id: 123})
        |> assign(:resource, %User{id: 123})
        |> UserController.unauthenticated_update()

      assert conn.halted
      assert conn.status == 401
    end
  end

  describe "check permisssion" do
    test "when is permitted", context do
      conn =
        context.conn
        |> put_private(:current_user, %User{id: 123})
        |> assign(:resource, %User{id: 123})
        |> UserController.update()

      refute conn.halted
      assert conn.status == 200
    end

    test "when isn't permitted", context do
      conn =
        context.conn
        |> put_private(:current_user, %User{id: 123})
        |> assign(:resource, %User{id: 321})
        |> UserController.update()

      assert conn.halted
      assert conn.status == 401
    end
  end

  describe "permit params" do
    setup context do
      put_in(context.conn.params, %{
        "name" => "my name",
        "email" => "email@email.com",
        "admin" => true
      })
    end

    test "when is permitted", context do
      conn =
        context.conn
        |> put_private(:current_user, %User{id: 123, admin: true})
        |> assign(:resource, %User{id: 123})
        |> UserController.update()

      refute conn.halted
      assert conn.status == 200
      assert conn.params["name"] == "my name"
      assert conn.params["email"] == "email@email.com"
      assert conn.params["admin"]
    end

    test "when isn't permitted", context do
      conn =
        context.conn
        |> put_private(:current_user, %User{id: 123})
        |> assign(:resource, %User{id: 123})
        |> UserController.update()

      refute conn.halted
      assert conn.status == 200
      assert conn.params["name"] == "my name"
      assert conn.params["email"] == "email@email.com"
      refute conn.params["admin"]
    end
  end

  describe "resoving controller" do
    test "when it's valid", context do
      conn =
        context.conn
        |> put_private(:current_user, %User{id: 123})
        |> assign(:resource, %User{id: 123})
        |> UserController.update()

      refute conn.halted
      assert conn.status == 200
    end

    test "when it's not valid", context do
      conn = UserController.update(context.conn)
      assert conn.halted
      assert conn.status == 401
    end
  end
end
