defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true

  def chain?(dominoes) do
    adj_map =
      Enum.reduce(dominoes, %{}, fn {l, r}, acc ->
        acc
        |> Map.update(l, [r], fn x -> [r | x] end)
        |> Map.update(r, [l], fn x -> [l | x] end)
      end)

    node_list = Map.keys(adj_map)

    is_connected?(
      get_visited_nodes(adj_map, List.first(node_list), MapSet.new()),
      MapSet.new(node_list)
    ) and is_eulerian_cycle?(adj_map)
  end

  defp is_connected?(visited_nodes, all_nodes), do: MapSet.equal?(visited_nodes, all_nodes)

  defp is_eulerian_cycle?(adj_map),
    do: Enum.reduce(adj_map, true, fn {_, adj}, acc -> rem(length(adj), 2) == 0 and acc end)

  defp get_visited_nodes(adj_map, current_node, visited) do
    visited = MapSet.put(visited, current_node)

    case Map.get(adj_map, current_node, []) do
      [] ->
        visited

      nodes ->
        Enum.reduce(nodes, visited, fn node, visited ->
          if node in visited do
            visited
          else
            get_visited_nodes(adj_map, node, visited)
          end
        end)
    end
  end
end
