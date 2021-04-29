# Sobre o Skeleton Phoenix

O Skeleton Phoenix é um facilitador para criação de controles em sua aplicação, permitindo que você tenha os métodos enxutos e auto explicativos.

## Instalação

```elixir
# mix.exs

def deps do
  [
    {:skeleton_phoenix, "~> 1.0.0"}
  ]
end
```

```elixir
# lib/app_web/controller.ex

defmodule App.Controller do
  @behaviour Skeleton.Phoenix.Controller

  defmacro __using__(_) do
    quote do
      use Skeleton.Phoenix.Controller, controller: App.AppWeb.Controller
    end
  end

  def is_authenticated(conn), do: conn.private[:current_user]

  def fallback(conn) do
    conn
  end
end
```

```elixir
# lib/app_web.ex

def controller do
  quote do
    use Skeleton.Phoenix.Controller
    # ...
  end
end
```

## Criando os controles

```elixir
# lib/app_web/controllers/user_controller.ex

defmodule AppWeb.UserController do
  use Skeleton.App.Controller

  def new(conn) do
    conn
    |> ensure_not_authenticated()
    |> resolve(fn conn ->
      conn
    end)
  end

  def update(conn) do
    conn
    |> ensure_authenticated()
    |> resolve(fn conn ->
      conn
    end)
  end
end
```