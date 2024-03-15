defmodule Diamond.MixProject do
  use Mix.Project

  def project do
    [
      app: :diamond,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:ex_doc, "~> 0.20", only: [:docs, :dev]}]
  end
end
