require_relative '../src/game_class'
require_relative '../src/player_class'

describe Game do
	before :each do
		@current_game = Game.new
	end
	describe "#new" do
		it "returns a game instance" do
			@new_game = Game.new
			@new_game.should be_an_instance_of Game
		end
		it "takes at most two integers as input" do
			Game.new.should be_an_instance_of Game
			Game.new(2,5000).should be_an_instance_of Game
			lambda { Game.new(2,11000,5) }.should raise_exception ArgumentError
		end

		it "keeps player_count between 2 and 8 inclusive" do
			(2..8).should include(@current_game.player_count)
		end

		it "populates player_list with player_count number of Player objects" do
			list = @current_game.instance_variable_get(:player_list)
			list.length.should be == @current_game.player_count
			list.each { |element| element.should be_an_instance_of Player }
		end

		it "populates player_standings with player_count number of id => score pairs" do
			hash = @current_game.player_standings
			hash.size.should be == @current_game.player_count
			hash.each do |id,score| 
				id.should be_an_instance_of Fixnum 
				(2..@current_game.player_count).should include(id)
				score.should be_an_instance_of Fixnum
				score.should be == 0
			end
		end
	end

	describe "#change_player" do
		it "returns the index of the next player" do
			@current_game.change_player.should be_an_instance_of Fixnum
		end
	end

	describe "#highest_scoring_player" do
		it "returns the player_ids with maximum score" do
			players = @current_game.highest_scoring_player
			players.each do |player|
				max_score = @current_game.player_standings.values.max
				@current_game.player_standings[player].should be == max_score
			end
		end
	end

	describe "#next_turn" do
		it "calls the next players play_turn method and changes to new player" do
			old_player = @current_game.next_player
			result = @current_game.next_turn
			
		end
	end
end
