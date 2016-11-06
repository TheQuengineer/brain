defmodule Brain.Mixfile do
  use Mix.Project

  def project do
    [app: :brain,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [
      applications: [
        :logger,
        :exmatrix
      ],
      mod: {Brain, []}
    ]
  end

  defp deps do
    [
      {:exmatrix, "~> 0.0.1"}
    ]
  end
end
