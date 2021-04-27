use Mix.Config

config :skeleton_phoenix, ecto_repos: [Skeleton.App.Repo]

config :skeleton_phoenix, Skeleton.App.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  hostname: System.get_env("POSTGRES_HOST", "localhost"),
  database: "skeleton_phoenix_test",
  password: System.get_env("POSTGRES_PASSWORD", "123456"),
  username: System.get_env("POSTGRES_USERNAME") || "postgres"

config :skeleton_phoenix, controller: Skeleton.App.Controller
config :skeleton_permission, permission: Skeleton.App.Permission
