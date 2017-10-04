class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :in_journey, :entry_station, :journeys

  def initialize
    @balance = 0
    @journeys = []
    @entry_station = nil
  end

  def top_up(amount)
    raise "This is above maximum balance!" if (amount + @balance) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Can't touch in without having touched out!" if @entry_station
    enough_money_to_travel?
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    raise "Can't touch out when not touched in!" if !@entry_station
    deduct(MINIMUM_CHARGE)
    @journeys << {entry_station: exit_station}
    @entry_station = nil
  end

  private

  def deduct(amount)
    raise "You can't have a balance less than zero!" if @balance < amount
    @balance -= amount
  end

  def enough_money_to_travel?
    raise "Insufficient balance to touch in!" if @balance < MINIMUM_CHARGE
  end

end
