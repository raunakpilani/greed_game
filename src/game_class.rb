require_relative './player_class'

class Game
  attr_reader :player_standings
  attr_reader :game_over
  attr_reader :player_count
  
  def initialize(players = 2, goal = 3000)
  	@goal = goal
  	@game_over = false
  	@player_standings = {}
  	@player_list = []
  	players = players.to_i
  	init_player_count(players)
  	init_list_n_standings
  	@next_player = 0
  	@last_round_first_player = -1
  end

  def init_list_n_standings
  	@player_count.times do |player_id|
  		@player_list << Player.new(player_id) 
  		@player_standings[player_id] = 0
  	end
  end

  def init_player_count(players)
  	case 
  	when players < 2 then @player_count = 2
  	when (2..8).member?(players) then @player_count = players
  	when players > 8 then @player_count = 8
  	else @player_count = 2
  	end 
  end

  def change_player
  	@next_player = (@next_player + 1) % @player_count
  end

  def highest_scoring_player
  	winners = []
  	max_score = @player_standings.values.max
  	@player_standings.each { |k,v| winners << k if v == max_score }
  	winners
  end

  def next_turn
  	puts "Next Player: #{@next_player}"
  	if @next_player == @last_round_first_player
  		@game_over = true
  		puts "GAME OVER!!"
  		winners = highest_scoring_player
  		puts "Won by #{winners}"
  		return @player_standings
  	end
  	score = @player_list[@next_player].play_turn
  	@player_standings[@next_player] += score
  	if @player_standings[@next_player] >= @goal && @last_round_first_player < 0
  		puts "LAST ROUND!!"
  		@last_round_first_player = @next_player
  	end
  	change_player
  	@player_standings
  end

end
