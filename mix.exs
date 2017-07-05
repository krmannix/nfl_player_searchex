defmodule NFLPlayerSearchex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :nfl_player_searchex,
      version: "0.3.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
    ]
  end

  def application do
    [
      extra_applications: [
        :logger,
        :httpoison,
      ],
    ]
  end

  defp deps do
    [
      {:floki, "~> 0.17.2"},
      {:httpoison, "~> 0.12.0"},
      {:ex_doc, "~> 0.13", only: :dev},
    ]
  end

  defp description do
    """
    Unofficial search for NFL players via the official NFL search
    """
  end

  defp package do
    [# These are the default files included in the package
     name: :nfl_player_searchex,
     maintainers: ["K. Rodman Mannix"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/krmannix/nfl_player_searchex"}
    ]
  end

end
