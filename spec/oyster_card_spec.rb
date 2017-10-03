require 'oyster_card.rb'

describe OysterCard do

  describe '#balance' do
    it 'tells customer whether the card has a balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top up' do
    it 'should top up the card' do
      val = rand(90)
      subject.top_up(val)
      expect(subject.balance).to eq val
    end
    it "shouldn't let an oyster card top up more than 90" do
      expect { subject.top_up(91) }.to raise_error("This is above maximum balance!")
    end
  end

  describe "#deduct" do
    it 'should deduct money from the card' do
      ded = rand(100)
      balance = subject.balance
      subject.deduct(ded)
      expect(subject.balance).to eq balance-ded
    end
  end
end
