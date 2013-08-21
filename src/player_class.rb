require_relative './dice_set_class'
class Player
	def initialize (player_id)
		@player_id = player_id
		@allowed_to_score = false
		@dice = DiceSet.new
	end

	def play_turn
		score = 0
		@dice.roll(5)
		new_roll = @dice.values
		new_score,scoring = score(new_roll)
		if new_score < 300 and !@allowed_to_score
			puts "Not allowed to score yet!"
			display_roll_scores(new_roll,new_score,score)
			return 0
		elsif @allowed_to_score
			score = new_score
			display_roll_scores(new_roll,new_score,score)
		elsif new_score >= 300
			score = new_score
			display_roll_scores(new_roll,new_score,score)
			puts "You can now score!!"
			@allowed_to_score = true
		end
		continue_to_roll = get_user_input("Score: #{score} Roll again? ") == "y" ? true : false
		
		while continue_to_roll
			dice_count = (scoring == new_roll.length) ? new_roll.length : (new_roll.length - scoring)
			puts "Dice count #{dice_count}"
			@dice.roll(dice_count)
			new_roll = @dice.values
			new_score,scoring = score(new_roll)
			if new_score == 0
				display_roll_scores(new_roll,new_score,0)
				return 0
			end
			score += new_score
			display_roll_scores(new_roll,new_score,score)
			continue_to_roll = get_user_input("Score: #{score} Roll again? ") == "y" ? true : false
		end
		score
	end

	def score(dice)
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
				score += (count / 3) * 1000 + (count % 3 ) * 100 if value == 1
				score += (count / 3) * 500 + (count % 3 ) * 50 if value == 5
				score += (count / 3) * value * 100 if value != 1 and value != 5
			end
			scoring += count if value == 1 || value == 5
			scoring += (count / 3) * 3 if value != 1 and value != 5
		end
		[score,scoring]
	end

	def get_user_input(message)
		print message + "> "
		return gets.chomp
	end

	def display_roll_scores(roll,roll_score,score)
		puts "Your Roll: #{roll} and its score: #{roll_score}\nTurn Score:#{score}"
	end

end
