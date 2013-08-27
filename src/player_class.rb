require_relative './dice_set_class'
class Player
  def initialize (player_id)
  	@player_id = player_id.to_i
  	@allowed_to_score = false
  	@dice = DiceSet.new
  end

  def roll_and_return(dice_count)
  	@dice.roll(dice_count)
  	@dice.values
  end

  def play_turn
  	score = 0
  	new_roll = roll_and_return(5)
  	new_score,scoring = score_and_scoring(new_roll)

  	@allowed_to_score = @allowed_to_score || (new_score >= 300)
  	score = (@allowed_to_score && new_score > 0) ? new_score : 0
  	display_roll_scores(new_roll,new_score,score)
  	puts "Allowed to score: #{@allowed_to_score}"

  	return score if score == 0
  	
  	while new_score > 0 && continue_to_roll?
  		dice_count = (scoring == new_roll.length) ? new_roll.length : (new_roll.length - scoring)
  		new_roll = roll_and_return(dice_count)
  		new_score,scoring = score_and_scoring(new_roll)
  		score,roll_again = new_score == 0 ? [new_score,false] : [(score + new_score),true]
  		display_roll_scores(new_roll,new_score,score)
  	end
  	score
  end

  def score_and_scoring(dice)
  	score = 0
  	scoring = 0
  	values = [1,2,3,4,5,6]
  	counts = values.inject({}) do |count_hash,value|
  		count_hash[value] = 0
  		count_hash
  	end
  	dice.each { |value| counts[value] += 1 }
  	counts.each do |value,count|
  		if count > 0
  			value == 1 && score += (count / 3) * 1000 + (count % 3 ) * 100
  			value == 5 && score += (count / 3) * 500 + (count % 3 ) * 50
  			(not [1,5].include? value) && score += (count / 3) * value * 100
  		end
  		scoring += count if value == 1 || value == 5
  		scoring += (count / 3) * 3 if value != 1 and value != 5
  	end
  	[score,scoring]
  end

  def continue_to_roll?
  	print "Roll again[y/n]? " 
  	gets.chomp.downcase == 'y' ? true : false
  end

  def display_roll_scores(roll,roll_score,score)
  	puts "\nYour Roll: #{roll} and its score: #{roll_score}... Turn Score:#{score}"
  end

end
