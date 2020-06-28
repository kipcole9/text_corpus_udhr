languages = [
  "en", "fr", "de-1996", "de-1901", "it", "es", "fi", "is",
  "el-monoton", "ru", "zh-Hans", "ja", "kr"
]

sample_lengths = [50, 100, 150, 300]

corpus = Text.Corpus.Udhr

Text.Streamer.matrix(corpus, languages, sample_lengths)
|> Text.Streamer.save_as_csv