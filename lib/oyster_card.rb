class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    if (amount + @balance) > MAXIMUM_BALANCE
      raise "This is above maximum balance!"
    else
      @balance += amount
    end
  end

  def touch_in
    if @balance >= MINIMUM_CHARGE
      @in_journey = true
    else
      raise "You must have more than #{MINIMUM_CHARGE} to travel!"
    end
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_journey = false
  end

  private

  def deduct(amount)
    if @balance >= amount
      @balance -= amount
    else
      raise "You can't have a balance less than zero!"
    end
  end

end
