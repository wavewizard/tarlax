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



  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
