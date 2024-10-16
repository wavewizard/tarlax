defmodule CustomRegistry do
  @table_name :station_registry

@moduledoc """
Bu adam bir kayıt defterine bakarak id ile sorgu yapıp node bulacak.
Kayıt defteri ets (erlang term storage)
döküman https://www.erlang.org/doc/apps/stdlib/ets.html

ETS Commands:
  :ets.new(:p, [:set, :named_table])   // Tablo tipleri " :set :ordered_set :bag "
  :ets -> process -> Node Bazli -> Cluster bazli icin Mnesia

  :ets.new(:test_table, [:set, :named_table])
  :ets.insert(:test_table, {:item1, 10})
  :ets.insert(:test_table, {:item2, 20})

  :ets.lookup(:test_table, :item1)
  :ets.tab2list(:test_table)

  :ets.tab2file(:test_table, 'path/file_name')
  :ets.delete(:test_table) // Oncelikle var olan tabloyu siliyoruz.
  :ets.file2tab('path/file_name')


Node Commands:
  Node Yaratma: iex --sname node1
                iex --name fullnodename

  # Eğer hostname tanımlanmamış ise (Örn: 192), bash'e "sudo scutil --set HostName yeni-hostname" verilmeli.
  Nodelari birbirine baglama: Node.connect(:full_nodename)

  Node.connect(:'node2@Host-Name')

"""

def start() do
end

#
# "TR", %80, NodePid
# "TR1", %20, NodePID
#

def start_link() do
  :ets.new(@table_name, [:set, :named_table])
end

def put_station(station_name, node_addres) do
  :ets.insert(@table_name, {station_name, node_addres})
end

def find_node(station_id) do
  :ets.lookup(@table_name, station_id)
end

def update_node_address(station_id, node) do
  IO.puts("hehe")
  :ets.insert(@table_name, {station_id, node})
end

def dispatch(data) do
 # %{station_id: "station1", payload: "hot"} [{istasyon_id, node_pid}]
 [{_station_id, node_pid}] = find_node(data.station_id)
 send(node_pid, {:process_station_data , data})


end



end
