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

  post "/status" do
    # Station periodically sends its status updates so corresponding Station updates its state
    # Message format {station_id : string, stasus: list}
    #example {station_id: "1234", status: {battery_level}}

    send_resp(conn, 200, "Station #{conn.body_params["battery_level"]}")
  end




  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
