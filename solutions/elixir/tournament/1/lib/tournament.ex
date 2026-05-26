defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()

  def tally([]), do: "Team                           | MP |  W |  D |  L |  P"

  def tally(input) do
    results =
      Enum.reduce(input, %{}, fn result, acc ->
        case String.split(result, ";") do
          [team_1, team_2, "win"] ->
            Map.update(acc, team_1, {1, 1, 0, 0, 3}, fn {mp, w, d, l, p} ->
              {mp + 1, w + 1, d, l, p + 3}
            end)
            |> Map.update(team_2, {1, 0, 0, 1, 0}, fn {mp, w, d, l, p} ->
              {mp + 1, w, d, l + 1, p}
            end)

          [team_1, team_2, "loss"] ->
            Map.update(acc, team_1, {1, 0, 0, 1, 0}, fn {mp, w, d, l, p} ->
              {mp + 1, w, d, l + 1, p}
            end)
            |> Map.update(team_2, {1, 1, 0, 0, 3}, fn {mp, w, d, l, p} ->
              {mp + 1, w + 1, d, l, p + 3}
            end)

          [team_1, team_2, "draw"] ->
            Map.update(acc, team_1, {1, 0, 1, 0, 1}, fn {mp, w, d, l, p} ->
              {mp + 1, w, d + 1, l, p + 1}
            end)
            |> Map.update(team_2, {1, 0, 1, 0, 1}, fn {mp, w, d, l, p} ->
              {mp + 1, w, d + 1, l, p + 1}
            end)

          _ ->
            acc
        end
      end)

    body =
      Enum.sort_by(results, fn {name, {_, _, _, _, p}} -> {-p, name} end)
      |> Enum.map(fn {name, {mp, w, d, l, p}} ->
        "#{String.pad_trailing(name, 30)} |#{format_stats(mp)} |#{format_stats(w)} |#{format_stats(d)} |#{format_stats(l)} |#{format_stats(p)}"
      end)
      |> Enum.join("\n")

    "Team                           | MP |  W |  D |  L |  P\n" <> body
  end

  defp format_stats(num) do
    String.pad_leading(Integer.to_string(num), 3)
  end
end
