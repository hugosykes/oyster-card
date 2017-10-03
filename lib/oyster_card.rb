class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "This is above maximum balance!" if (amount + @balance) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in
    raise "Can't touch in without having touched out!" if @in_journey
    enough_money_to_travel?
    @in_journey = true
  end

  def touch_out
    raise "Can't touch out when not touched in!" if !@in_journey
    deduct(MINIMUM_CHARGE)
    @in_journey = false
  end

  private

  def deduct(amount)
    raise "You can't have a balance less than zero!" if @balance < amount
    @balance -= amount
  end

  def enough_money_to_travel?
    raise "You must have more than #{MINIMUM_CHARGE} to travel!" if @balance < MINIMUM_CHARGE
  end

end
