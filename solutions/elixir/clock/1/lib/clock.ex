defmodule Clock do
  @type t() :: %__MODULE__{hour: integer, minute: integer}
  defstruct hour: 0, minute: 0

  @mins_in_day 1440
  @mins_in_hour 60

  defp to_mins(hour, minute), do: hour * @mins_in_hour + minute

  defp from_mins(mins) do
    parsed_mins = Integer.mod(mins, @mins_in_day)
    %__MODULE__{hour: div(parsed_mins, @mins_in_hour), minute: rem(parsed_mins, @mins_in_hour)}
  end

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: t()
  def new(hour, minute), do: to_mins(hour, minute) |> from_mins()

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(t(), integer) :: t()
  def add(%Clock{hour: hour, minute: minute}, add_minute),
    do: Clock.new(hour, minute + add_minute)
end

defimpl String.Chars, for: Clock do
  defp format_time(time),
    do:
      time
      |> Integer.to_string()
      |> String.pad_leading(2, "0")

  def to_string(%Clock{hour: hour, minute: minute}),
    do: "#{format_time(hour)}:#{format_time(minute)}"
end
