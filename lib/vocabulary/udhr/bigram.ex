defmodule Text.Vocabulary.Udhr.Bigram do
  @moduledoc """
  An n-gram vocabulary composed
  of bi-grams

  """

  @behaviour Text.Vocabulary

  @app Mix.Project.config[:app]

  alias Text.Vocabulary

  @default_ngram 2

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
    Vocabulary.get_vocabulary(language, __MODULE__)
  end

  @impl Text.Vocabulary
  def filename do
    Path.join(:code.priv_dir(@app), "vocabulary/udhr_bigram.etf")
  end

  @impl Text.Vocabulary
  def calculate_ngrams(text) do
    Vocabulary.calculate_ngrams(text, ngram_range())
  end
end
