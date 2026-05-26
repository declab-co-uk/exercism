defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score(score) do
    case to_vec(score) do
      result when result <= 1 -> 10
      result when result <= 5 -> 5
      result when result <= 10 -> 1
      _ -> 0
    end
  end

  def to_vec({x, y}) do
    (x ** 2 + y ** 2) |> :math.sqrt()
  end
end
