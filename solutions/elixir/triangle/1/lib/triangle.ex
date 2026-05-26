defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0,
    do: {:error, "all side lengths must be positive"}

  def kind(a, a, a), do: {:ok, :equilateral}
  def kind(a, b, c) when a == b or b == c or c == a, do: validate_triangle(a, b, c, :isosceles)
  def kind(a, b, c), do: validate_triangle(a, b, c, :scalene)

  defp validate_triangle(a, b, c, expected_type) do
    if a + b >= c and b + c >= a and a + c >= b do
      {:ok, expected_type}
    else
      {:error, "side lengths violate triangle inequality"}
    end
  end
end
