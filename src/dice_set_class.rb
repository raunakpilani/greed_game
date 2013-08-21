class DiceSet
  attr_reader :values
  def initialize
    @values = []
  end
  def roll(number)
    old_values = @values
    begin
      @values = []
      number.times { @values << (rand(6) + 1) }
    end until old_values != @values
  end
end
