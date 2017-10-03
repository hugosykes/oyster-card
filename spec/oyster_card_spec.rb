require 'oyster_card.rb'

describe OysterCard do
  describe '#balance' do
    it 'tells customer their balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top up' do
    it 'should top up the card' do
      val = rand(OysterCard::MAXIMUM_BALANCE)
      expect { subject.top_up(val) }.to change { subject.balance }.by(val)
    end

    it "shouldn't let an oyster card top up more than #{OysterCard::MAXIMUM_BALANCE}" do
      expect { subject.top_up(OysterCard::MAXIMUM_BALANCE + 1) }.to raise_error("This is above maximum balance!")
    end
  end

  describe "#touching in and out" do
    context "reporting journey status" do
      it "should report that it is not in a journey when first instantiated" do
        expect(subject.in_journey).to eq false
      end

      context "balance == minimum charge" do
        let (:subject) do
          oyster = OysterCard.new
          oyster.top_up(OysterCard::MINIMUM_CHARGE)
          oyster
        end

        it "should report that it is in a journey when touched in" do
          subject.touch_in
          expect(subject.in_journey).to eq true
        end

        it "touching in then touching out should report: not in journey" do
          subject.touch_in
          subject.touch_out
          expect(subject.in_journey).to eq false
        end

        it "should raise error if touch_in is called twice without touch_out in between" do
          subject.touch_in
          expect { subject.touch_in }.to raise_error "Can't touch in without having touched out!"
        end

        it "should raise error if touch_out is called when not in journey" do
          expect { subject.touch_out }.to raise_error "Can't touch out when not touched in!"
        end
      end
    end

    context "charging for journeys" do
      it "should raise an error when touching in on a balance of less than the minimum travelling balance" do
        expect { subject.touch_in }.to raise_error("You must have more than #{OysterCard::MINIMUM_CHARGE} to travel!")
      end

      it "should charge for journeys in the touch_out method" do
        subject.top_up(OysterCard::MINIMUM_CHARGE)
        subject.touch_in
        expect { subject.touch_out }.to change { subject.balance }.by(-OysterCard::MINIMUM_CHARGE)
      end
    end
  end
end
