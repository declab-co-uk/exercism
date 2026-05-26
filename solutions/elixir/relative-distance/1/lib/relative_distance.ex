defmodule RelativeDistance do
  @doc """
  Find the degree of separation of two members given a given family tree.
  Thanks to Jeremy Kubica for the book Graph algorithms the fun way, it saved me on this one!
  """
  @spec degree_of_separation(
          family_tree :: %{String.t() => [String.t()]},
          person_a :: String.t(),
          person_b :: String.t()
        ) :: nil | pos_integer()
  def degree_of_separation(family_tree, person_a, person_b) do
    seen = MapSet.new([person_a])
    pending = :queue.new()
    pending = :queue.in(person_a, pending)
    last = %{person_a => nil}

    bfs(seen, last, pending, create_graph(family_tree), person_b)
    |> walk_tree(person_b)
  end

  defp walk_tree(nil, _), do: nil
  defp walk_tree(last, name, count \\ 0)
  defp walk_tree(_, nil, count), do: count - 1

  defp walk_tree(tree, name, count) do
    walk_tree(tree, Map.get(tree, name), count + 1)
  end

  defp create_graph(tree) do
    for {parent, children} <- tree,
        child <- children,
        reduce: tree do
      acc ->
        new_relations = [parent | children] -- [child]

        Map.update(acc, child, new_relations, fn existing ->
          Enum.uniq(existing ++ new_relations)
        end)
    end
  end

  defp bfs(seen, last, pending, tree, target) do
    case :queue.out(pending) do
      {{:value, ^target}, _} ->
        last

      {{:value, current}, pending} ->
        neighbors = Map.get(tree, current, [])

        {updated_pending, updated_last, updated_seen} =
          for neighbor <- neighbors,
              not MapSet.member?(seen, neighbor),
              reduce: {pending, last, seen} do
            {p, l, s} ->
              {:queue.in(neighbor, p), Map.put_new(l, neighbor, current), MapSet.put(s, neighbor)}
          end

        bfs(updated_seen, updated_last, updated_pending, tree, target)

      {:empty, _} ->
        nil
    end
  end
end
