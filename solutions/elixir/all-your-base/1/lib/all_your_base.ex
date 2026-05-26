defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    with {:ok, _, base_10_float} <- convert_from(digits, input_base),
         {:ok, converted} <- convert_to(floor(base_10_float), output_base) do
      converted = if converted == [], do: [0], else: converted
      {:ok, converted |> :lists.reverse()}
    end
  end

  defp convert_from(_, input_base) when input_base < 2, do: {:error, "input base must be >= 2"}
  defp convert_from([], _), do: {:ok, 0, 0}

  defp convert_from([h | t], input_base) do
    with :ok <- validate_digit(h, input_base),
         {:ok, exponent, value} <- convert_from(t, input_base) do
      {:ok, exponent + 1, value + h * :math.pow(input_base, exponent)}
    end
  end

  defp convert_to(_, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  defp convert_to(0, _), do: {:ok, []}

  defp convert_to(value, output_base) do
    with {:ok, acc} <- convert_to(div(value, output_base), output_base) do
      {:ok, [rem(value, output_base) | acc]}
    end
  end

  defp validate_digit(i, input_base) when i >= 0 and i < input_base, do: :ok

  defp validate_digit(_, _),
    do: {:error, "all digits must be >= 0 and < input base"}
end
