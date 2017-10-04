require 'oyster_card.rb'

describe OysterCard do

  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }
  let (:subject) do
    oyster = OysterCard.new
    oyster.top_up(OysterCard::MINIMUM_CHARGE)
    oyster
  end

  describe '#balance' do
    it 'tells customer their balance' do
      expect(subject.balance).to eq OysterCard::MINIMUM_CHARGE
    end
  end

  describe '#top up' do
    it 'should top up the card' do
      val = rand(OysterCard::MAXIMUM_BALANCE - OysterCard::MINIMUM_CHARGE)
      expect { subject.top_up(val) }.to change { subject.balance }.by(val)
    end

    it "shouldn't let an oyster card top up more than #{OysterCard::MAXIMUM_BALANCE}" do
      expect { subject.top_up(OysterCard::MAXIMUM_BALANCE) }.to raise_error("This is above maximum balance!")
    end
  end

  describe "#touching in and out" do
    context "reporting journey status" do
      it "should report that it is not in a journey when first instantiated" do
        expect(subject.entry_station).to eq nil
      end

      it "should register an entry station once touched in" do
        subject.touch_in(entry_station)
        expect(subject.entry_station).to_not eq nil
      end

      it "touching in then touching out should report: not in journey" do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.entry_station).to eq nil
      end

      it "should raise error if touch_in is called twice without touch_out in between" do
        subject.touch_in(entry_station)
        expect { subject.touch_in(entry_station) }.to raise_error "Can't touch in without having touched out!"
      end

      it "should raise error if touch_out is called when not touched in" do
        expect { subject.touch_out(exit_station) }.to raise_error "Can't touch out when not touched in!"
      end
    end

    context "charging for journeys" do
      let(:oyster) { OysterCard.new }
      it "should raise an error when touching in on a balance of less than the minimum travelling balance" do
        expect { oyster.touch_in(entry_station) }.to raise_error("Insufficient balance to touch in!")
      end

      it "should charge for journeys in the touch_out method" do
        subject.touch_in(entry_station)
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-OysterCard::MINIMUM_CHARGE)
      end
    end

    context "entry and exit stations" do
      it "should remember the station it entered after touch_in is called" do
        subject.touch_in(entry_station)
        expect(subject.entry_station).to eq entry_station
      end

      it "should have an exposed list of historical journeys" do
        expect(subject.journeys).to_not eq nil
      end
    end
  end
end
