defmodule House do
  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @poem_lookup %{
    1 => {"house that Jack built", nil},
    2 => {"malt", "lay in the"},
    3 => {"rat", "ate the"},
    4 => {"cat", "killed the"},
    5 => {"dog", "worried the"},
    6 => {"cow with the crumpled horn", "tossed the"},
    7 => {"maiden all forlorn", "milked the"},
    8 => {"man all tattered and torn", "kissed the"},
    9 => {"priest all shaven and shorn", "married the"},
    10 => {"rooster that crowed in the morn", "woke the"},
    11 => {"farmer sowing his corn", "kept the"},
    12 => {"horse and the hound and the horn", "belonged to the"}
  }

  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    (start..stop |> Enum.map(&verse/1) |> Enum.join("\n")) <> "\n"
  end

  def verse(verse_number) do
    {animal, _} = Map.get(@poem_lookup, verse_number)

    "This is the #{animal}" <>
      Enum.map_join(verse_number..2//-1, "", fn n ->
        {_, verb} = Map.get(@poem_lookup, n)
        {prev_animal, _} = Map.get(@poem_lookup, n - 1)
        " that #{verb} #{prev_animal}"
      end) <> "."
  end
end
