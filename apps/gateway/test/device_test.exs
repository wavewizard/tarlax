defmodule DeviceTest do
  use ExUnit.Case

  test "make device" do
  expected = %Device{id: "1234", sensors: Device.make_ports(5), battery: Battery.make_battery(100, 100, ~D[2024-01-01])}

  device = Device.make_device("1234", 5)

  assert device == expected
  end

end
