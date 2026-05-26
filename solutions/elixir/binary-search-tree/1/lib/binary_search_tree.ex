defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(tree, data) do
    do_insert(tree, data)
  end

  defp do_insert(node, new_data) do
    case node do
      %{data: data, left: nil} = val when data >= new_data ->
        Map.put(val, :left, new(new_data))

      %{data: data, right: nil} = val when data < new_data ->
        Map.put(val, :right, new(new_data))

      %{data: data, left: left} = val when data >= new_data ->
        %{val | left: do_insert(left, new_data)}

      %{data: data, right: right} = val when data < new_data ->
        %{val | right: do_insert(right, new_data)}
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree) do
    do_in_order(tree, []) |> Enum.reverse()
  end

  defp do_in_order(node, acc) do
    case node do
      %{data: data, left: nil, right: nil} ->
        [data | acc]

      %{data: data, left: left, right: nil} ->
        [data | do_in_order(left, acc)]

      %{data: data, left: nil, right: right} ->
        do_in_order(right, [data | acc])

      %{data: data, left: left, right: right} ->
        l = [data | do_in_order(left, acc)]
        do_in_order(right, l)
    end
  end
end
