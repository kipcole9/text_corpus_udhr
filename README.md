# Text Corpus UDHR

[Text](https://hex.pm/packages/text) corpus from the Universal Declaration of Human Rights. This is an addon package for [Text](https://hex.pm/packages/text).

## Installation

```elixir
def deps do
  [
    {:text_corpus_udhr, "~> 0.1.0"}
  ]
end
```

## Usage

This library supports the `Text.Corpus` behaviour and can be used to support natural language detection. The primary API for language detection is with `Text.Language.detect/2`:
```elixir
iex> Text.Language.detect "this is some english language thing"                                  {:ok, "en"}

# Options include `:corpus`, `:vocabulary` and `:classifier`
iex> Text.Language.detect "this is some english language thing", corpus: Text.Corpus.Udhr, vocabulary: Text.Vocabulary.Udhr.Quadgram
{:ok, "en"}
```

The full results of classification can be returned from `Text.Language.classify/2`:
```elixir
iex> Text.Language.classify "this is some english language thing"                                [
  {"en", -358.1044082598717},
  {"sco", -362.0624489962793},
  {"hlt", -371.5322712458512},
  {"tsz", -371.5733160983161},
  {"fy", -374.86324995116945},
  {"ami", -376.568015153406},
  {"uz-Latn", -377.144506010214},
  {"ug-Latn", -377.48114167890884},
  {"pam", -377.84818762771334},
  {"tzm", ...},
  {...},
  ...
]

## Detection Accuracy

Detection accuracy is reliable at text lengths of 150 characters or more, reasonable at 100 characters and may not be considered acceptable at shorter lengths.

The results are consistent for the range of tested languages with German being a clear exception (see the later section):

* English
* Greek
* Russian
* Spanish
* Finnish
* French
* Icelandic
* Italian
* Japanese
* Simplified Chinese

Further details are contained in the [github repo](https://github.com/kipcole9/text_corpus_udhr) in the `analysis` directory.

#### English language with Naive Bayesian classifier

`Text.Language.detect/2` with `classifier: Text.Classifier.NaiveBayesian` and three different vocabularies.

| Text Length            | Udhr.Bigram | Udhr.Multigram | Udhr.Quadgram |
|------------------------|-------------|----------------|---------------|
| 50                     | 95.6%       | 92.7%          | 95.6%         |
| 100                    | 99.9%       | 99.5%          | 98.8%         |
| 150                    | 100.0%      | 100.0%         | 99.3%         |
| 300                    | 100.0%      | 100.0%         | 100.0%        |

#### English language with Cummulative Frequency classifier

`Text.Language.detect/2` with `classifier: Text.Classifier.CummulativeFrequency` and three different vocabularies.

| Text Length            | Udhr.Bigram | Udhr.Multigram | Udhr.Quadgram |
|------------------------|-------------|----------------|---------------|
| 50                     | 94.8%       | 94.4%          | 95.4%         |
| 100                    | 99.4%       | 98.6%          | 98.3%         |
| 150                    | 100.0%      | 99.9%          | 99.6%         |
| 300                    | 100.0%      | 100.0%         | 100.0%        |

#### English language with Rank Order classifier

`Text.Language.detect/2` with `classifier: Text.Classifier.RankOrder` and three different vocabularies.

| Text Length            | Udhr.Bigram | Udhr.Multigram | Udhr.Quadgram |
|------------------------|-------------|----------------|---------------|
| 50                     | 95.3%       | 94.9%          | 95.4%         |
| 100                    | 99.7%       | 99.0%          | 98.7%         |
| 150                    | 100.0%      | 100.0%         | 99.4%         |
| 300                    | 100.0%      | 100.0%         | 100.0%        |

#### Accuracy for German language detection

German is an exception to the consistent accuracy of most languages and the results are poor. Further analysis is required to understand the underlying cause.

| Text Length | Udhr.Bigram | Udhr.Multigram | Udhr.Quadgram |
|------------|-------------|----------------|---------------|
| 50         | 45.6%       | 38.0%          | 27.2%         |
| 100        | 64.4%       | 47.2%          | 42.3%         |
| 150        | 71.6%       | 57.6%          | 51.4%         |
| 300        | 78.7%       | 47.2%          | 56.9%         |

