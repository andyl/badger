defmodule BadgerWeb.MixProject do
  use Mix.Project

  def project do
    [
      app: :badger_web,
      version: "0.0.1",
      elixir: "~> 1.9",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {BadgerWeb.Application, []},
      extra_applications: [:logger, :runtime_tools, :timex, :phoenix_ecto]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # ----- phoenix backend
      {:phoenix, "~> 1.4.6"},
      {:plug_cowboy, "~> 2.0"},
      {:phoenix_html, "~> 2.13"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.1.0"},
      # ----- phoenix view helpers
      {:phoenix_active_link, "~> 0.3.0"},
      {:phoenix_live_view, "~> 0.3.1"},
      # {:phoenix_live_editable, path: "~/lib/phoenix_live_editable"},
      # ----- util
      {:jason, "~> 1.0"},
      {:gettext, "~> 0.11"},
      {:memoize, "~> 1.3"},
      {:timex, "~> 3.1"},
      # ----- monitoring and tracing
      {:observer_cli, "~> 1.5"},
      # ----- development and test
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      # ----- umbrella
      {:badger_data, in_umbrella: true}
    ]
  end
end
