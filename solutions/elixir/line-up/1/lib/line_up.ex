defmodule LineUp do
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """
  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number) do
    number_suffix =
      case {div(number, 10) |> rem(10), rem(number, 10)} do
        {val, 1} when val != 1 -> "st"
        {val, 2} when val != 1 -> "nd"
        {val, 3} when val != 1 -> "rd"
        _ -> "th"
      end

    "#{name}, you are the #{number}#{number_suffix} customer we serve today. Thank you!"
  end
end
