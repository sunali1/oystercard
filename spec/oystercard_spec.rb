require 'oystercard'

describe Oystercard do
subject(:card){ described_class.new }
let(:entry_station) {double :station}
let(:exit_station) {double :station}
let(:journey) { {entry_station: :station, exit_station: :station} }

  it "has a balance of zero" do
  expect(card.balance).to eq(0)
  end

  describe "#top up" do
  it "is able to topup and add to balance" do
  expect(card).to respond_to(:topup).with(1).argument
  expect{ card.topup(1) }.to change{ card.balance }.by 1
  end
  end

  it "does not exceed topup limit" do
  max_balance = Oystercard::MAX_BALANCE
  message = "Unable to topup; limit is #{max_balance}"
  card.topup(max_balance)
  expect { card.topup(1) }.to raise_error message
  end

  describe "#deduct" do
    it "is able to deduct from balance on touch_out" do
    card.topup(10)
    card.touch_in(:station)
    expect{ card.touch_out(:station) }.to change{ card.balance }.by -(Oystercard::MIN_FARE)
    end
  end

  it "is initially not in journey" do
    expect(card).not_to be_in_journey
  end

  it "lets you touch_in" do
    card.topup(10)
    card.touch_in(:station)
    #expect(card).to be_in_journey
  end

  it "stores the exit_station" do
    card.topup(10)
    card.touch_in(:station)
    card.touch_out(:station)
    expect(card.exit_station).to eq(:station)
  end

  it "doesn't let you touch_in if no min balance" do
  min_balance = Oystercard::MIN_BALANCE
  #card.topup(10)
  #card.touch_in
  message = "Insufficient funds"
  expect { card.touch_in(:station) }.to raise_error message
  end

  it "has an empty list of journeys by default" do
   expect(card.journey).to be_empty
  end

  it "stores a journey" do
    #min_balance = Oystercard::MIN_BALANCE
    card.topup(10)
    card.touch_in(:station)
    card.touch_out(:station)
    expect(card.journey).to include(journey)
  end
end
