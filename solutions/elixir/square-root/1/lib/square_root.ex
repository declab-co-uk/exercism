defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer

  def calculate(1), do: 1

  def calculate(radicand) do
    find_initial_estimate(radicand)
    |> newtons_method(radicand)
  end

  defp newtons_method(current, target) when current * current != target do
    newtons_method((current + target / current) / 2, target)
  end

  defp newtons_method(current, _), do: current

  defp find_initial_estimate(radicand) do
    [h | t] =
      case Integer.digits(radicand, 2) do
        [_ | t] = val when rem(length(t), 2) == 1 -> [0 | val]
        val -> val
      end

    a = h + binary_fraction_to_float(t)
    n = div(length(t), 2)
    approx = 0.5 + 0.5 * a
    approx * 2 ** n
  end

  defp binary_fraction_to_float(binary_fraction, divisor \\ 2, acc \\ 0)
  defp binary_fraction_to_float([], _, acc), do: acc

  defp binary_fraction_to_float([h | t], divisor, acc) do
    binary_fraction_to_float(t, divisor * 2, acc + h / divisor)
  end
end
