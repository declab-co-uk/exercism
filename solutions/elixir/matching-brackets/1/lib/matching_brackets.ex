defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    containers = %{"]" => "[", "}" => "{", ")" => "("}

    str
    |> String.graphemes()
    |> Enum.filter(fn char -> char in ["[", "{", "(", "]", "}", ")"] end)
    |> Enum.reduce_while([], fn
      char, acc when char in ["[", "{", "("] ->
        {:cont, [char | acc]}

      _, [] ->
        {:halt, :error}

      char, [h | t] ->
        if Map.get(containers, char) == h do
          {:cont, t}
        else
          {:halt, :error}
        end
    end) == []
  end
end
