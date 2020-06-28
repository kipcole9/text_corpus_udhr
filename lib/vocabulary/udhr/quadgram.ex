defmodule Text.Vocabulary.Udhr.Quadgram do
  @moduledoc """
  An n-gram vocabulary composed
  of quad-grams

  """

  @behaviour Text.Vocabulary

  @app Mix.Project.config[:app]

  alias Text.Vocabulary

  @default_ngram 4

  @impl Text.Vocabulary
  def load_vocabulary! do
    Vocabulary.load_vocabulary!(__MODULE__)
  end

  @impl Text.Vocabulary
  def ngram_range do
    @default_ngram..@default_ngram
  end

  @impl Text.Vocabulary
  def get_vocabulary(language) do
    Text.Vocabulary.get_vocabulary(__MODULE__, language)
  end

  @impl Text.Vocabulary
  def filename do
    Path.join(:code.priv_dir(@app), "vocabulary/udhr_quadgram.etf")
  end

  @impl Text.Vocabulary
  def calculate_ngrams(text) do
    Vocabulary.calculate_ngrams(text, ngram_range())
  end
end
