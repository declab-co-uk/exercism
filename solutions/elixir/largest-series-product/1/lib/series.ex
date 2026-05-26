defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(_, size) when size < 0,
    do: raise(ArgumentError, "span size cannot be negative")

  def largest_product(string, size) do
    cond do
      String.length(string) < size -> raise ArgumentError, "string needs to be longer than size"
      string =~ ~r/\D/ -> raise ArgumentError, "string must be an integer"
      true -> do_largest_product(string, size)
    end
  end

  defp do_largest_product(<<h::binary-size(1), t::binary>>, size) do
    case t do
      <<m::binary-size(size - 1), _::binary>> ->
        max(calculate_product(h <> m), do_largest_product(t, size))

      _ ->
        0
    end
  end

  defp calculate_product(string) when is_binary(string) do
    String.graphemes(string)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(1, &*/2)
  end
end
