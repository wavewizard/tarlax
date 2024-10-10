defmodule Battery do
  defstruct [:amper, :charge_level,  :date_of_production]

  @type t() :: %__MODULE__{amper: integer(), charge_level: integer(), date_of_production: Date.t()}

  def set_battery_level(battery, level) do
    %{battery |charge_level: level}
  end

  def make_battery(amper, charge_level, date_of_production) do
    %__MODULE__{amper: amper, charge_level: charge_level, date_of_production: date_of_production}
  end


  def age(battery) do
    Date.diff(Date.utc_today(), battery.date_of_production)
  end

  def level(battery) do
    battery.level
  end


end
