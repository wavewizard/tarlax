defmodule GatewayTest do
  use ExUnit.Case
  doctest Gateway
  test "device battery level change should update station device state" do
    Station.start_auto1()

    req_json =  %{station_id: "1234", message: %{message_type: "device_battery_level_changed", device_id: "aaaa", level: 60}}
    Req.post!("http://localhost:4000/message", json: req_json).body

    :timer.sleep(50)

    station = Station.get_status("1234")

    the_device = station.devices |> Map.get("aaaa")
    assert 60 = the_device.battery.charge_level
  end

    test "station battery change" do
      Station.start_auto1()
      station_id = "1234"
      expected_level = 60
      req_json =  %{
        station_id: station_id,
       message: %{message_type: "station_battery_level_changed",
       level: expected_level}}

       # Request i gonder
       Req.post!("http://localhost:4000/message", json: req_json).body

      # Station statusunu oku
      station=Station.get_status(station_id)
      # station pil seviyesi request edilenle ayni mi

   assert expected_level == station.battery.charge_level

  end



end
