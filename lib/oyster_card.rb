class OysterCard

  MAXIMUM_BALANCE = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "This is above maximum balance!" if (amount + @balance) > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    raise "You can't have a balance less than zero!" if (@balance - amount) < 0
    @balance -= amount
  end

end
