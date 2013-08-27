require_relative '../src/dice_set_class'

describe DiceSet do
  describe "#new" do
    it "returns a dice_set object containing an empty values array" do
      dice_obj = DiceSet.new
      dice_obj.should be_an_instance_of DiceSet
      dice_obj.values.should be_an_instance_of Array
    end
  end
  describe "#roll" do
    it "rolls a number of dice using rand method and populates values array" do
      DiceSet.any_instance.should_receive(:rand).with(6).exactly(5).times.and_return(3,1,2,3,0)
      dice_obj = DiceSet.new
      dice_obj.roll(5)
    end
  end
end
