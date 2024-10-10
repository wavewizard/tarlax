defmodule Sensor do
  @type state :: :on | :off
  defstruct [:sensor_type, :state, :last_reading]

  def make_sensor(type) do
    %Sensor{sensor_type: type, state: :off, last_reading: nil}
  end

  def on(sensor) do
    %{sensor | state: :on}
  end

  def off(sensor) do
    %{sensor | state: :off}
  end

  def update_last_reading(sensor, reading) do
    %{sensor | last_reading: reading}
  end



end
