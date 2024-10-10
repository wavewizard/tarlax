defmodule StationModel do
alias Battery

  @type state :: :online | :offline | :unknown
  defstruct [:id, :name, :battery, :state, :configuration, :ports, :devices]

  @type t() :: %StationModel{
    id: String.t(),
    name: String.t(),
    battery: Battery.t(),
    state: state(),
    configuration: map(),
    ports: map(),
    devices: map()
  }

  def make_station(name, id, number_of_ports, devices) do
    %StationModel{
      name: name,
      id: id,
      ports: create_ports(number_of_ports),
      devices: devices,
      battery: Battery.make_battery(50, 100, ~D[2023-01-01]),
      configuration: %{}
    }
  end

  defp create_ports(nr_of_port) do
    Enum.reduce(1 .. nr_of_port, %{}, fn port, acc -> Map.put(acc, port, :off) end)
  end

  def open_port(station, port_number) do
    port_map = Map.update!(station.ports, port_number, fn _ -> :on end)
    %{station | ports: port_map}
  end

  def close_port(station, port_number) do
    port_map = Map.update!(station.ports, port_number, fn _ -> :off end)
    %{station | ports: port_map}
  end

  def update_battery_level(station, level) do
    %{station | battery: Battery.set_battery_level(station.battery, level)}

  end

  def update(station,  args) do

  end



end
