defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase, " ") |> Enum.map_join(" ", &translate_word/1)
  end

  defp translate_word(word) do
    cond do
      Regex.run(~r/^([aeiou]|xr|yt)\w+$/, word) ->
        word <> "ay"

      match = Regex.run(~r/^([^aeiou]+)(y\w*)$/, word) ->
        [_, start, rest] = match
        rest <> start <> "ay"

      match = Regex.run(~r/^([^aeiou]*qu)(\w+)$/, word) ->
        [_, start, rest] = match
        rest <> start <> "ay"

      match = Regex.run(~r/^([^aeiou]+)(\w+)$/, word) ->
        [_, start, rest] = match
        rest <> start <> "ay"
    end
  end
end
