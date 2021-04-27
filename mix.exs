defmodule SkeletonPhoenix.MixProject do
  use Mix.Project

  @version "1.0.0"
  @url "https://github.com/skeleton-elixir/skeleton_phoenix"
  @maintainers [
    "Diego Nogueira",
    "Jhonathas Matos"
  ]


  def project do
    [
      name: "SkeletonPhoenix",
      app: :skeleton_phoenix,
      version: @version,
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      source_url: @url,
      maintainers: @maintainers,
      description: "Elixir structure",
      start_permanent: Mix.env() == :prod,
      deps: deps()

    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.4"},
      {:ecto_sql, "~> 3.5"},
      {:postgrex, "~> 0.15"},
      {:skeleton_permission, github: "skeleton-elixir/skeleton_permission"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      maintainers: @maintainers,
      licenses: ["MIT"],
      links: %{github: @url},
      files: ~w(lib) ++ ~w(CHANGELOG.md LICENSE mix.exs README.md)
    ]
  end
end
