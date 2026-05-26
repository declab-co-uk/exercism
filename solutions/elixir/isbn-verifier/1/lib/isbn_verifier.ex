defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    remove_dash =
      isbn
      |> String.to_charlist()
      |> Enum.reject(&(&1 == ?-))

    formatted_isbn =
      remove_dash
      |> Enum.reduce_while([], fn x, acc ->
        case x do
          ?X -> {:halt, [10 | acc]}
          val when val in ?0..?9 -> {:cont, [String.to_integer(<<val>>) | acc]}
          _ -> {:cont, acc}
        end
      end)
      |> Enum.reverse()

    if length(remove_dash) != 10 or length(formatted_isbn) != 10 do
      false
    else
      formatted_isbn
      |> Enum.reduce({0, 10}, fn x, {total, multiplier} ->
        {total + x * multiplier, multiplier - 1}
      end)
      |> then(fn {total, _} -> rem(total, 11) == 0 end)
    end
  end
end
