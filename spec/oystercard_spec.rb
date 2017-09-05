require 'oystercard'

describe Oystercard do
subject(:card){ described_class.new }

  it"has a balance of zero" do
  expect(card.balance).to eq(0)
  end

  describe "#top up" do
  it "is able to topup" do
  expect(card).to respond_to(:topup).with(1).argument
  expect{ card.topup(1) }.to change{ card.balance }.by 1
  end
  end

  it "does not exceed topup limit" do
  max_balance = Oystercard::MAX_BALANCE
  message = "Unable to topup; limit is £90"
  card.topup(max_balance)
  expect { card.topup(1) }.to raise_error message
  end

end
