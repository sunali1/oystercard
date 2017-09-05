require 'oystercard'

describe Oystercard do
subject(:card){ described_class.new }

  it"has a balance of zero" do
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
    it "is able to deduct from balance" do
    card.topup(10)
    card.touch_out
    expect(card).to respond_to(:deduct).with(1).argument
    expect{ card.deduct(5) }.to change{ card.balance }.by -5
    end
  end

  it "is initially not in journey" do
    expect(card).not_to be_in_journey
  end

  it "lets you touch_in" do
    card.topup(10)
    card.touch_in
    expect(card).to be_in_journey
  end

  it "lets you touch_out" do
    card.topup(10)
    #card.touch_in
    card.touch_out
    expect(card).not_to be_in_journey
  end

  it "doesn't let you touch_in if no min balance" do
  min_balance = Oystercard::MIN_BALANCE
  #card.topup(10)
  #card.touch_in
  message = "Insufficient funds"
  expect { card.touch_in }.to raise_error message
  end
end
