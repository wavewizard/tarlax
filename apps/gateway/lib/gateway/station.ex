defmodule Station do
  use GenServer

  def start_link(station) do
    GenServer.start_link(__MODULE__, station, name: {:via, Registry, {StationRegistry, station.id}})

  end

  @impl GenServer
  def init(station) do

    {:ok, station }
  end

  @impl GenServer
  def handle_call(:get_status, _from, state) do
    {:reply, state, state}
  end



  def start_auto1() do
    station = StationModel.make_station("test", "1234", 5)
    device = Device.make_device("aaaa", 5)
    station = StationModel.add_device(station, device)
    Station.start_link(station)
  end







  @impl GenServer
  def handle_cast({:set_battery_level, level}, state) do
    new_state = StationModel.update_battery_level(state, level)
    {:noreply, new_state}
  end

  def handle_cast({:handle_message,message},state) do
    IO.puts("#{message["device_id"]}, #{message["level"]}")
    new_state =  parse_message(message, state)

    {:noreply,  new_state}
  end





  ### CLIENT API ####

  def set_battery_level(station_id, level) do

    GenServer.cast({:via, Registry, {StationRegistry, station_id}}, {:set_battery_level, level})
  end

  def get_status(station_id) do
    GenServer.call({:via, Registry, {StationRegistry, station_id}}, :get_status)
  end


  def send_message(station_id,message) do

    GenServer.cast({:via,Registry,{StationRegistry,station_id}},{:handle_message,message["message"]})

    #Station.send_message("1234", message)

  end

  ### PRIVATE FUNCTIONS###

  defp parse_message(message, station) do
    case message["message_type"] do
      "device_battery_level_changed"  ->
        StationModel.update_device_battery_level(station, message["device_id"], message["level"])
         "station_battery_level_changed"  ->
        StationModel.update_battery_level(station, message["level"])
      _ -> {:error, "unknown message type"}
    end

  end


end
