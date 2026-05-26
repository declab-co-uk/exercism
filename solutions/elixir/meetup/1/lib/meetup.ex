defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @schedule_map %{teenth: 0, first: 0, second: 1, third: 2, fourth: 3, last: -1}
  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, schedule) do
    {:ok, start_of_month} = Date.new(year, month, 1)

    case schedule do
      :teenth ->
        Date.range(Date.new!(year, month, 13), Date.new!(year, month, 19))

      _ ->
        Date.range(start_of_month, Date.end_of_month(start_of_month))
    end
    |> get_date(schedule, weekday)
  end

  defp get_date(days_list, schedule, weekday) do
    days_list
    |> Enum.filter(fn d -> Date.day_of_week(d, weekday) == 1 end)
    |> Enum.at(Map.get(@schedule_map, schedule))
  end
end
