# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {%{}, 1} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {state, _} -> Map.values(state) end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {state, next_id} ->
      new_plot = %Plot{plot_id: next_id, registered_to: register_to}
      {new_plot, {Map.put(state, next_id, new_plot), next_id + 1}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {state, next_id} ->
      {Map.delete(state, plot_id), next_id}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn {state, _} ->
      Map.get(state, plot_id, {:not_found, "plot is unregistered"})
    end)
  end
end
