defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean

  def valid?(number) do
    num_list =
      number
      |> String.graphemes()
      |> Enum.reduce_while([], fn i, acc ->
        if i == " " do
          {:cont, acc}
        else
          case Integer.parse(i) do
            {int, _} -> {:cont, [int | acc]}
            :error -> {:halt, :error}
          end
        end
      end)

    case num_list do
      [_, _ | _] ->
        num_list
        |> Enum.chunk_every(2)
        |> Enum.reduce(0, fn [h | t], acc ->
          acc + h +
            case t do
              [] ->
                0

              [num] ->
                if(num * 2 >= 10, do: num * 2 - 9, else: num * 2)
            end
        end)
        |> then(fn result -> rem(result, 10) == 0 end)

      _ ->
        false
    end
  end
end
