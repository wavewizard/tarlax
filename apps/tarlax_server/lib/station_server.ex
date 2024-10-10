defmodule Station do
  use GenServer

  def start_link(args) do
    station_id = args[:id]
    GenServer.start_link(__MODULE__, args, name: station_id)
  end

  @impl GenServer
  def init(args) do
    station = StationModel.make_station(args["name"], args["id"], args["number_of_ports"])
    {:ok, station}
  end

  @impl GenServer
  def handle_call(:status, _from, station) do
    {:reply, station.battery_level, station}
  end

  @impl GenServer
  def handle_cast({:set_battery_level, level}, station) do
    new_state = StationModel.update_battery_level(station, level)
    {:noreply, new_state}
  end

  ##############
  # CLIENT API #
  ##############

  def set_battery_level(station_id, level) do
  end

  def get_status(station_id) do
  end
end
