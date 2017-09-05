class Oystercard

MAX_BALANCE = 90
MIN_BALANCE = 1

attr_reader :balance
attr_reader :in_use

def initialize
  @balance = 0
  @in_use = false

end

def topup(amount)
  fail "Unable to topup; limit is #{MAX_BALANCE}" if amount + balance > MAX_BALANCE
  @balance += amount
end

  def deduct(fare)
  @balance -= fare
  end

  def touch_in
    fail "Insufficient funds" if @balance < MIN_BALANCE
    @in_use = true
    return "You have touched in"
  end

  def touch_out
    @in_use = false
    return "You have touched out"
  end

  def in_journey?
    @in_use
  end

end
