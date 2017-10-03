class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BAL_TO_TRAVEL = 1
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "This is above maximum balance!" if (amount + @balance) > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    raise "You can't have a balance less than zero!" if (@balance - amount) < 0
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @balance >= MINIMUM_BAL_TO_TRAVEL ? @in_journey = true : raise("You must have more than #{MINIMUM_BAL_TO_TRAVEL} to travel!")
  end

  def touch_out
    @in_journey = false
  end
end
