defmodule Text.Corpus.Udhr.Index do
  @moduledoc false

  import SweetXml

  @corpus_dir "./corpus/udhr"
  @languages_filename "udhr_languages"
  @languages_path Path.join(@corpus_dir, @languages_filename)

  @corpus_index @corpus_dir
          |> Path.join(["index.xml"])
          |> File.read!()
          |> xpath(~x"//udhrs/udhr"l,
            iso639: ~x"./@iso639-3"s,
            bcp47: ~x"./@bcp47"s,
            script: ~x"./@iso15924"s,
            stage: ~x"./@stage"I,
            name: ~x"./@n"s,
            file: ~x"./@f"s
          )
          |> Enum.map(&Map.pop(&1, :bcp47))
          |> Enum.filter(fn {_k, v} -> v[:stage] >= 4 end)
          |> Enum.map(fn {k, v} -> {k, v.file} end)
          |> Map.new()


  File.write!(@languages_path, :erlang.term_to_binary(@corpus_index))

end
