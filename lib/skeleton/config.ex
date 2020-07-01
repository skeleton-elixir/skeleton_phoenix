defmodule Skeleton.Phoenix.Config do
  def controller, do: config(:controller)

  def config(key, default \\ nil) do
    Application.get_env(:skeleton_phoenix, key, default)
  end
end