defmodule Gateway.StationService do
  use Plug.Router

  plug :match

  plug Plug.Parsers,
  parsers: [:json],
  pass:  ["application/json"],
  json_decoder: Jason

  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Hello, World!")
  end

  post "/hello" do
    IO.inspect conn.body_params # Prints JSON POST body
    send_resp(conn, 200, "Success!")
  end

  post "/status_update" do
    # Station periodically sends its status updates so corresponding Station updates its state
    # Message format {station_id : string, stasus: list}
    #Message Protocol
    #StationId: 128 bit
    #Message type 8 bit = 256 different message types
    #Message payload variable size
    #example {station_id: "1234", changes: [
    #battery_level_changed: 50,
    #device_battery_level_changed: {id: 1,  battery_level: 100
    #devices should not be sent as a status update as there can be 100 device attached to a station
    #so device status should be sent to different contract
    #In that sense station should always send what has changed!!! Thats the responsibility of Station(hw)
    #message will be passed to GenServer
    IO.inspect conn.body_params # Prints JSON POST body
    send_resp(conn, 200, "Station #{conn.body_params["status"]}")
  end





  match _ do
    send_resp(conn, 404, "Not Found")
  end

end
