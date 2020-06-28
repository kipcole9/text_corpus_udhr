runner =
  Text.Language.known_classifiers
  |> Enum.map(fn classifier ->
    {inspect(classifier), &Text.Language.detect(hd(&1), classifier: classifier)}
  end)

language = "en"
corpus = Text.Corpus.Udhr

Benchee.run(
  runner,
  inputs: %{
     "50 characters" => Enum.take(Text.Streamer.corpus_random_stream(corpus, language, 50), 1),
    "100 characters" => Enum.take(Text.Streamer.corpus_random_stream(corpus, language, 100), 1),
    "150 characters" => Enum.take(Text.Streamer.corpus_random_stream(corpus, language, 150), 1),
  }
)