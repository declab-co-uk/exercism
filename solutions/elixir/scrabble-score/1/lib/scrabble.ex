defmodule Scrabble do
  @scores [
            {~w(A E I O U L N R S T), 1},
            {~w(D G), 2},
            {~w(B C M P), 3},
            {~w(F H V W Y), 4},
            {~w(K), 5},
            {~w(J X), 8},
            {~w(Q Z), 10}
          ]
          |> Enum.flat_map(fn {letters, score} ->
            Enum.map(letters, &{&1, score})
          end)
          |> Map.new()

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.graphemes()
    |> Enum.reduce(0, fn x, acc ->
      acc + Map.get(@scores, String.upcase(x), 0)
    end)
  end
end
