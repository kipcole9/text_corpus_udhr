defmodule Text.Corpus.Udhr.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :text_corpus_uhdr,
      version: @version,
      docs: docs(),
      elixir: "~> 1.8",
      name: "Text Corpus UDHR",
      source_url: "https://github.com/kipcole9/text_corpus_udhr",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore_warnings",
        plt_add_apps: ~w(inets jason mix)a
      ]
    ]
  end

  defp description do
    """
    Corpus for the `Text` library from the Universal Declaration of Human Rights.
    """
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      maintainers: ["Kip Cole"],
      licenses: ["Apache 2.0"],
      links: links(),
      files: [
        "lib",
        "priv",
        "mix.exs",
        "README*",
        "CHANGELOG*",
        "LICENSE*"
      ]
    ]
  end

  def docs do
    [
      source_ref: "v#{@version}",
      main: "readme",
      logo: "logo.png",
      skip_undefined_reference_warnings_on: ["changelog", "CHANGELOG.md"],
      extras: ["README.md", "CHANGELOG.md", "LICENSE.md"]
    ]
  end

  defp deps do
    [
      {:text, path: "../text"},
      {:sweet_xml, "~> 0.6", only: [:dev, :test], optional: true},
      {:ex_doc, "~> 0.21", only: [:dev, :release], optional: true},
      {:benchee, "~> 1.0", only: :dev, runtime: false}
    ]
  end

  def links do
    %{
      "GitHub" => "https://github.com/kipcole9/text_corpus_udhr",
      "Readme" => "https://github.com/kipcole9/text_corpus_udhr/blob/v#{@version}/README.md",
      "Changelog" => "https://github.com/kipcole9/text_corpus_udhr/blob/v#{@version}/CHANGELOG.md"
    }
  end

  defp elixirc_paths(:test), do: ["lib", "mix", "test"]
  defp elixirc_paths(:dev), do: ["lib", "mix", "bench"]
  defp elixirc_paths(_), do: ["lib"]
end
