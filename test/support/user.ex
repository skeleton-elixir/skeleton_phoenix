defmodule Skeleton.Phoenix.User do
  use Skeleton.Phoenix.App, :schema

  schema "users" do
    field :name, :string
    field :email, :string
    field :admin, :boolean

    timestamps()
  end
end