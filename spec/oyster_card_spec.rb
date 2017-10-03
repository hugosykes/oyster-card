require 'oyster_card.rb'

describe OysterCard do
  describe '#balance' do
    it 'tells customer whether the card has a balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top up' do
    it 'should top up the card' do
      val = rand(OysterCard::MAXIMUM_BALANCE)
      subject.top_up(val)
      expect(subject.balance).to eq val
    end

    it "shouldn't let an oyster card top up more than 90" do
      expect { subject.top_up(OysterCard::MAXIMUM_BALANCE + 1) }.to raise_error("This is above maximum balance!")
    end
  end

  describe "#deduct" do
    it 'should deduct money from the card' do
      subject.top_up(OysterCard::MAXIMUM_BALANCE)
      val = rand(OysterCard::MAXIMUM_BALANCE)
      subject.deduct(val)
      expect(subject.balance).to eq (OysterCard::MAXIMUM_BALANCE - val)
    end
  end

  describe "#touching in and out" do
    context "reporting journey status" do
      it "should report that it is not in a journey when first instantiated" do
        expect(subject.in_journey?).to eq false
      end

      it "should report that it is in a journey when touched in" do
        subject.top_up(1)
        subject.touch_in
        expect(subject.in_journey?).to eq true
      end

      it "touching in then touching out should report: not in journey" do
        subject.top_up(1)
        subject.touch_in
        subject.touch_out
        expect(subject.in_journey?).to eq false
      end
    end

    context "charging for journeys" do

      it "should raise an error when touching in on a balance of less than the minimum travelling balance" do
        expect { subject.touch_in }.to raise_error("You must have more than #{OysterCard::MINIMUM_BAL_TO_TRAVEL} to travel!")
      end

    end
  end
end
