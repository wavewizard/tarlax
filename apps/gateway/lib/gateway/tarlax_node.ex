defmodule Gateway.TarlaxNode do

  def start(node_name) do
    spawn(fn  -> loop(node_name) end)
  end

  def loop(node_name) do
    receive do
      {:process_station_data, station_data} -> IO.puts("Node #{node_name} received #{inspect(station_data)}")
      loop(node_name)
      _ -> {:error, "message not known"}
         loop(node_name)
    endchunks
  end



end
