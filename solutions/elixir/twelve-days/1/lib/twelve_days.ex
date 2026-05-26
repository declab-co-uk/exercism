defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """

  @items %{
    12 => {"twelfth", "twelve Drummers Drumming"},
    11 => {"eleventh", "eleven Pipers Piping"},
    10 => {"tenth", "ten Lords-a-Leaping"},
    9 => {"ninth", "nine Ladies Dancing"},
    8 => {"eighth", "eight Maids-a-Milking"},
    7 => {"seventh", "seven Swans-a-Swimming"},
    6 => {"sixth", "six Geese-a-Laying"},
    5 => {"fifth", "five Gold Rings"},
    4 => {"fourth", "four Calling Birds"},
    3 => {"third", "three French Hens"},
    2 => {"second", "two Turtle Doves"},
    1 => {"first", "a Partridge in a Pear Tree"}
  }

  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    {number_as_string, _} = Map.get(@items, number)

    items =
      Enum.zip_reduce(1..number, @items, [], fn x, {_, {_, line}}, acc ->
        if number > 1 and x == 1, do: ["and " <> line | acc], else: [line | acc]
      end)
      |> Enum.join(", ")

    "On the #{number_as_string} day of Christmas my true love gave to me: #{items}."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(fn v -> verse(v) end)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
