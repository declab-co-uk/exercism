defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    Regex.scan(~r/[a-zA-Z\d]+('[a-zA-Z]+)?/, sentence)
    |> Enum.flat_map(fn [h | _] -> [h] end)
    |> Enum.frequencies_by(&String.downcase/1)
  end
end
