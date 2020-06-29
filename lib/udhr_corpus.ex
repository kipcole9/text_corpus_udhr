defmodule Text.Corpus.Udhr do
  @moduledoc """




  """

  @behaviour Text.Corpus

  @corpus_dir "./corpus/udhr"

  @languages_filename "vocabulary/udhr_languages.etf"
  @app_name Mix.Project.config[:app]
  @languages_path Path.join(:code.priv_dir(@app_name), @languages_filename)

  @corpus_index File.read!(@languages_path) |> :erlang.binary_to_term
  @known_languages Map.keys(@corpus_index)

  @known_vocabularies [
    Text.Vocabulary.Udhr.Quadgram,
    Text.Vocabulary.Udhr.Bigram,
    Text.Vocabulary.Udhr.Multigram
  ]

  @impl Text.Corpus
  def known_languages do
    @known_languages
  end

  @impl Text.Corpus
  def classify(text, options \\ []) do
    options = Keyword.put(options, :corpus, __MODULE__)
    Text.Language.classify(text, options)
  end

  @impl Text.Corpus
  def detect(text, options \\ []) do
    options = Keyword.put(options, :corpus, __MODULE__)
    Text.Language.detect(text, options)
  end

  @impl Text.Corpus
  def known_vocabularies do
    @known_vocabularies
  end

  @impl Text.Corpus
  def language_content(language) when language in @known_languages do
    udhr_corpus_dir()
    |> Path.join(udhr_language_file(language))
    |> File.read!()
    |> String.split("---")
    |> Enum.at(1)
    |> String.trim()
  end

  @impl Text.Corpus
  def normalize_text(text) do
    String.replace(text, ~r/\s+/u, " ")
  end

  @doc false
  def udhr_language_file(language) do
    udhr_corpus_index()
    |> Map.fetch!(language)
    |> udhr_corpus_file
  end

  @doc false
  def udhr_corpus_file(file) do
    "udhr_" <> file <> ".txt"
  end

  @doc false
  def udhr_corpus_dir do
    @corpus_dir
  end

  @doc false
  def udhr_corpus_index do
    @corpus_index
  end

end