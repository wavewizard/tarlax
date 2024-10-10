defmodule Device do
  alias Sensor

  defstruct [:id, :sensors, :battery]

  def make_device(id, number_of_ports) do
    %Device{id: id, sensors: make_ports(number_of_ports), battery: Battery.make_battery(100, 100)}

  end

  def make_ports(nr_of_port) do
    Enum.reduce(1 .. nr_of_port, %{}, fn port, acc -> Map.put(acc, port, nil) end)
  end


  def plug_sensor(device, port, sensor) do
    sensors = Map.update!(device.sensors, port, fn _old -> sensor end)
    %{device | sensors: sensors }
  end

  def remove_sensor(device, port) do
    sensors = Map.update!(device.sensors, port, fn _old -> nil end)
    %{device | sensors: sensors}

  end

  def turn_sensor_off(device, port) do
    sensors = Map.update!(device.sensors, port, fn sensor -> Sensor.off(sensor) end)
    %{device | sensors: sensors}

  end

  def turn_sensor_on(device, port) do
    sensors = Map.update!(device.sensors, port, fn sensor -> Sensor.on(sensor) end)
    %{device | sensors: sensors}
  end

  def update_battery_level(device, level) do
    battery = Battery.set_battery_level(device.battery, level)
    %{device | battery: battery}
  end



end
