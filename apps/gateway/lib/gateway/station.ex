defmodule Station do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: {:via, Registry, {StationRegistry, args[:id]}})

  end

  @impl GenServer
  def init(args) do
    IO.puts("#{inspect(args)}")
  station = StationModel.make_station(args[:name], args[:id], args[:number_of_ports], %{})
    {:ok, station }
  end

  @impl GenServer
  def handle_call(:get_status, _from, state) do
    {:reply, state, state}
  end

  @impl GenServer
  def handle_cast({:set_battery_level, level}, state) do
    new_state = StationModel.update_battery_level(state, level)
    {:noreply, new_state}
  end

  ### CLIENT API ####

  def set_battery_level(station_id, level) do

    GenServer.cast({:via, Registry, {StationRegistry, station_id}}, {:set_battery_level, level})
  end

  def get_status(station_id) do
    GenServer.call({:via, Registry, {StationRegistry, station_id}}, :get_status)
  end


end
