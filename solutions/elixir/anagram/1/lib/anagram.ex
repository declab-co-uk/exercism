defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_map = base |> to_char_map()

    Enum.filter(candidates, fn x ->
      Map.equal?(base_map, x |> to_char_map()) and String.upcase(base) != String.upcase(x)
    end)
  end

  defp to_char_map(string) do
    string
    |> String.split("", trim: true)
    |> Enum.reduce(%{}, fn x, acc ->
      x = String.upcase(x)
      Map.update(acc, x, 1, fn k -> k + 1 end)
    end)
  end
end
