defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none"), do: %__MODULE__{nickname: nickname}

  def display_distance(%__MODULE__{distance_driven_in_meters: meters}),
    do: "#{meters} meters"

  def display_battery(%__MODULE__{battery_percentage: battery}) when battery > 0,
    do: "Battery at #{battery}%"

  def display_battery(%__MODULE__{}), do: "Battery empty"

  def drive(%__MODULE__{} = remote_car) when remote_car.battery_percentage > 0,
    do: %__MODULE__{
      remote_car
      | battery_percentage: remote_car.battery_percentage - 1,
        distance_driven_in_meters: remote_car.distance_driven_in_meters + 20
    }

  def drive(%__MODULE__{} = remote_car), do: remote_car
end
