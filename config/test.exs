use Mix.Config

config :skeleton_phoenix, ecto_repos: [Skeleton.App.Repo]

config :skeleton_phoenix, Skeleton.App.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "skeleton_phoenix_test",
  username: System.get_env("SKELETON_PHOENIX_DB_USER") || System.get_env("USER") || "postgres"

config :logger, :console, level: :error

config :skeleton_phoenix, controller: Skeleton.App.Controller
config :skeleton_permission, permission: Skeleton.App.Permission