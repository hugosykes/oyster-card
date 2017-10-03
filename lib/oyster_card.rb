class OysterCard

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "This is above maximum balance!" if (amount + @balance) > 90
    @balance += amount
  end

  def deduct(cost)
    @balance -= cost
  end
  
end
