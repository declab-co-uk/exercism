defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """
  @numbers %{
    10 => "ten",
    9 => "nine",
    8 => "eight",
    7 => "seven",
    6 => "six",
    5 => "five",
    4 => "four",
    3 => "three",
    2 => "two",
    1 => "one",
    0 => "no"
  }
  @spec recite(pos_integer, pos_integer) :: String.t()

  def recite(_, 0), do: ""

  def recite(start_bottle, take_down) do
    start_bottle..(start_bottle - take_down + 1)//-1
    |> Enum.map(&generate_verse/1)
    |> Enum.join("\n\n")
  end

  defp bottle_plural(1), do: "bottle"
  defp bottle_plural(_), do: "bottles"

  defp generate_verse(verse_number) do
    current = Map.get(@numbers, verse_number) |> String.capitalize()
    next = Map.get(@numbers, verse_number - 1)

    "#{current} green #{bottle_plural(verse_number)} hanging on the wall,
#{current} green #{bottle_plural(verse_number)} hanging on the wall,
And if one green bottle should accidentally fall,
There'll be #{next} green #{bottle_plural(verse_number - 1)} hanging on the wall."
  end
end
