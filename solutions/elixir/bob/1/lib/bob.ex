defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    is_empty = input =~ ~r/^\s*$/
    is_question = input =~ ~r/\A.+\?(\s+)?\Z/ms
    has_shouting = input =~ ~r/[[:upper:]]+/u
    has_talking = input =~ ~r/[[:lower:]]+/u

    case {is_empty, is_question, has_shouting, has_talking} do
      {true, _, _, _} -> "Fine. Be that way!"
      {_, true, true, false} -> "Calm down, I know what I'm doing!"
      {_, false, true, false} -> "Whoa, chill out!"
      {_, true, _, _} -> "Sure."
      _ -> "Whatever."
    end
  end
end
