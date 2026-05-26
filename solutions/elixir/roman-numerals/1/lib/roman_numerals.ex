defmodule RomanNumerals do
  @numerals [
    M: 1000,
    CM: 900,
    D: 500,
    CD: 400,
    C: 100,
    XC: 90,
    L: 50,
    XL: 40,
    X: 10,
    IX: 9,
    V: 5,
    IV: 4,
    I: 1
  ]
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    do_numeral(number, @numerals)
  end

  defp do_numeral(0, _), do: ""

  defp do_numeral(number, [{numeral_atom, value} | t]) do
    if value <= number do
      String.duplicate(Atom.to_string(numeral_atom), div(number, value)) <>
        do_numeral(rem(number, value), t)
    else
      do_numeral(number, t)
    end
  end
end
