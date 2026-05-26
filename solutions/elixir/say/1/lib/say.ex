defmodule Say do
  @numbers %{
    0 => "zero",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety",
    100 => "hundred",
    1000 => "thousand",
    1_000_000 => "million",
    1_000_000_000 => "billion"
  }

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}

  def in_english(number) when number < 0 or number > 999_999_999_999,
    do: {:error, "number is out of range"}

  def in_english(number), do: {:ok, do_in_english(number)}

  def do_in_english(number) when number < 20, do: Map.get(@numbers, number)

  def do_in_english(number) when number >= 20 and number < 100 do
    case rem(number, 10) do
      0 -> Map.get(@numbers, number)
      r -> Map.get(@numbers, number - r) <> "-" <> Map.get(@numbers, r)
    end
  end

  def do_in_english(number) when number < 1000, do: recursive_lookup(number, 100)
  def do_in_english(number) when number < 1_000_000, do: recursive_lookup(number, 1000)
  def do_in_english(number) when number < 1_000_000_000, do: recursive_lookup(number, 1_000_000)

  def do_in_english(number) when number < 1_000_000_000_000,
    do: recursive_lookup(number, 1_000_000_000)

  defp recursive_lookup(number, divisor) do
    div = div(number, divisor)

    case rem(number, divisor) do
      0 ->
        [
          do_in_english(div),
          Map.get(@numbers, divisor)
        ]

      r ->
        [
          do_in_english(div),
          Map.get(@numbers, divisor),
          do_in_english(r)
        ]
    end
    |> Enum.join(" ")
  end
end
