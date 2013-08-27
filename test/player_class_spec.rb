require_relative '../src/player_class'

describe Player do
  before :each do
    @new_player = Player.new(0)
  end
  describe "#new" do
    it "returns an object player with integer player_id as input argument" do
      @test_player = Player.new(0)
      @test_player.should be_an_instance_of Player
      @test_player.instance_variable_get(:@player_id).should be_an_instance_of Fixnum
    end
    it "takes exactly one argument" do
      lambda { Player.new }.should raise_exception ArgumentError
      lambda { Player.new }.should raise_exception ArgumentError
    end
    it "creates an object of the DiceSet class" do
      @new_player.instance_variable_get(:@dice).should be_an_instance_of DiceSet
    end
  end 

  describe "#play_turn" do
    it "calls roll dice, score calculation and performs a user turn" do
      Player.any_instance.should_receive(:roll_and_return).with(5).and_return([1,2,3,4,5])
      
      @new_player.play_turn
    end
  end

  describe "#roll_and_return" do
    it "calls the roll instance of the dice_set object and returns the roll values" do
      DiceSet.any_instance.should_receive(:roll).with(5).and_return(nil)
      values = @new_player.roll_and_return(5)
      values.should be_an_instance_of Array
    end
  end

  describe "#score_and_scoring" do
    it "scores a roll and lists the number of dice that were scoring" do
      result = @new_player.score_and_scoring([1,2,3,1,5])
      score,scoring = result
      result.should be_an_instance_of Array
      result.each { |value| value.should be_an_instance_of Fixnum }
      score.should be == 250
      scoring.should be == 3
    end
  end

  describe "#continue_to_roll?" do
    it "gets user input and returns a true for 'y' and false otherwise" do
      Player.any_instance.should_receive(:gets).with(no_args()).and_return('y')
      result = @new_player.continue_to_roll?
      result.should be 
    end
  end

  describe "#display_roll_scores" do
    it "takes exactly 3 arguments" do
      lambda { @new_player.display_roll_scores(12,45) }.should raise_exception ArgumentError 
      lambda { @new_player.display_roll_scores(12,34,56,78) }.should raise_exception ArgumentError 
      lambda { @new_player.display_roll_scores(12,34,56) }.should_not raise_exception
    end
  end
end
