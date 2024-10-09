defmodule StationModel do

  @type state :: :online | :offline | :unknown
  defstruct [:id, :name, :battery_level, :state, :configuration, :ports, :devices]

  @type t() :: %StationModel{
    id: String.t(),
    name: String.t(),
    battery_level: integer(),
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
      configuration: %{}
    }
  end

  def create_ports(nr_of_port) do
    port_map = Map.new()
    Enum.reduce(1 .. nr_of_port, %{}, fn port, acc -> Map.put(acc, port, :offline) end)
  end



  def update_battery_level(station, level) do
    %{station | battery_level: level}
  end



end
