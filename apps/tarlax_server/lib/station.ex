defmodule StationModel do
  @type state :: :online | :ofline
  defstruct [:name, :id, :devices, :state, :battery_level, :last_message_time, :ports, :config]

  @type t() :: %__MODULE__{
          name: String.t(),
          id: String.t(),
          devices: map(),
          state: state(),
          battery_level: :integer,
          last_message_time: DateTime.t(),
          ports: map(),
          config: map()
        }

  def make_station(name, id, number_of_ports) do
    %StationModel{name: name, id: id, ports: create_ports(number_of_ports)}
  end

  def create_ports(nr_of_ports) do
    Enum.reduce(1..nr_of_ports, %{}, fn port_no, acc -> Map.put(acc, port_no, :off) end)
  end

  def update_battery_level(station, level) do
    %{station | battery_level: level}
  end

  def turn_on_port(station, port_number) do
    %{station | ports: Map.update!(station.ports, port_number, fn _old_value -> :on end)}
  end

  def turn_off_port(station, port_number) do
    %{station | ports: Map.update!(station.ports, port_number, fn _old_value -> :off end)}
  end

  def set_name(station, name) do
    %{station | name: name}
  end

  def update_last_message_time(station, time) do
    %{station | last_message_time: time}
  end
end
