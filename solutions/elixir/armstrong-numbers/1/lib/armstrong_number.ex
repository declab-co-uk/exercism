defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    length = length(digits)

    digits
    |> Enum.reduce(0, fn digit, acc ->
      acc + digit ** length
    end)
    |> then(&(&1 == number))
  end
end
