defmodule PlugApp.Mixfile do
  use Mix.Project

  def project do
    [app: :plug_app,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: [server: ["app.start", &server/1]],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :cowboy, :plug, :poison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:plug, "~> 1.0"},
      {:poison, "~> 1.5"}
    ]
  end

  defp server(_) do
    port = String.to_integer( System.get_env("PORT") || "3999" )

    Mix.shell.info "Running Totec practice on port #{port}"
    {:ok, _} = Plug.Adapters.Cowboy.http Plug.App, [], port: port
    :code.delete(Access)
    :timer.sleep(:infinity)
  end
end
