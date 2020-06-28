defmodule Text.Vocabulary.Udhr.Multigram do
  @moduledoc """
  An n-gram vocabulary composed
  of n-grams ranging from 2 to 4
  characters in length

  """

  @behaviour Text.Vocabulary

  @app Mix.Project.config[:app]

  alias Text.Vocabulary

  @ngram_range 2..4

  @impl Text.Vocabulary
  def load_vocabulary! do
    Vocabulary.load_vocabulary!(__MODULE__)
  end

  @impl Text.Vocabulary
  def ngram_range do
    @ngram_range
  end

  @impl Text.Vocabulary
  def get_vocabulary(language) do
    Text.Vocabulary.get_vocabulary(__MODULE__, language)
  end

  @impl Text.Vocabulary
  def filename do
    Path.join(:code.priv_dir(@app), "vocabulary/udhr_multigram.etf")
  end

  @impl Text.Vocabulary
  def calculate_ngrams(text) do
    Vocabulary.calculate_ngrams(text, ngram_range())
  end
end
