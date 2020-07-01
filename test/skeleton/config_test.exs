defmodule Skeleton.ConfigTest do
  use Skeleton.App.TestCase
  alias Skeleton.Phoenix.Config
  alias Skeleton.App.Controller

  test "returns controller module" do
    assert Config.controller() == Controller
  end
end