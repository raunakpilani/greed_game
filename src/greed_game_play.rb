require_relative './game_class.rb'
gm = Game.new(5)
gm.player_standings

until gm.game_over do
  puts
  puts gm.next_turn
  print "Any key to continue: "
  gets
end
