defmodule GatewayTest do
  use ExUnit.Case
  doctest Gateway

  test "greets the world" do
    Station.start_link(%{name: "test", id: "1234", number_of_ports: 5})
  end
end
