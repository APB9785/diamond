defmodule Diamond.MixProject do
  use Mix.Project

  @gh_url "https://github.com/APB9785/diamond"
  @version "0.1.0"

  def project do
    [
      app: :diamond,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      description:
        "A read-only in-memory key/value storage optimized for the fastest possible read times",
      package: package(),

      # Docs
      name: "Diamond",
      docs: docs()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:ex_doc, "~> 0.20", only: [:docs, :dev]}]
  end

  defp package do
    [
      maintainers: ["Andrew P Berrien"],
      licenses: ["GPL-3.0"],
      links: %{
        "Changelog" => "#{@gh_url}/blob/master/CHANGELOG.md",
        "GitHub" => @gh_url
      }
    ]
  end

  defp docs do
    [
      main: "Diamond",
      source_ref: "v#{@version}",
      logo: nil,
      source_url: @gh_url,
      extras: extras()
    ]
  end

  defp extras do
    [
      "CHANGELOG.md"
    ]
  end
end
