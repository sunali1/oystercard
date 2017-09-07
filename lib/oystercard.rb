class Oystercard

MAX_BALANCE = 90
MIN_BALANCE = 1
MIN_FARE = 2

attr_reader :balance
attr_reader :in_use
attr_accessor :entry_station
attr_accessor :exit_station
attr_accessor :journey

def initialize
  @balance = 0
  #@in_journey = false
  @entry_station = nil
  @exit_station = nil
  @stations = []
  #@journey_history = {}
  @journey = {}
end

def topup(amount)
  fail "Unable to topup; limit is #{MAX_BALANCE}" if amount + balance > MAX_BALANCE
  @balance += amount
end

  def touch_in(entry_station)
    fail "Insufficient funds" if @balance < MIN_BALANCE
    @in_journey = true
    puts "You have touched in"
    @entry_station = entry_station
  #  #@stations << entry_station
    @journey.store(:entry_station, entry_station)
  end

  def touch_out(exit_station)
    deduct
    @in_journey = false
    puts "You have touched out"
    @entry_station = nil
    @exit_station = exit_station
    @journey.store(:exit_station, exit_station)
    @journey
  end

  def in_journey?
    @entry_station != nil
  end

  private
  def deduct
  @balance -= MIN_FARE
  return @balance
  end
end
