defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(fn char ->
      case char do
        c when c in ?a..?z -> shift_chars(c, ?a, shift)
        c when c in ?A..?Z -> shift_chars(c, ?A, shift)
        c -> c
      end
    end)
    |> to_string()
  end

  defp shift_chars(char, range_start, shift),
    do: range_start + rem(char - range_start + shift, 26)
end
