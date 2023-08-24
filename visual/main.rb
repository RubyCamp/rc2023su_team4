require 'dxruby'
require_relative 'map'
require_relative 'map_navigator'

Window.width = 1300
Window.height = 1000

map = Map.new("map_data/map_test.dat")

route = [[3,2],[3,1],[3,0],[2,0],[1,0],[1,1],[1,2],[2,2],[2,1],[1,1],[0,1],[0,2],[1,2],[2,2],[3,2],[3,1],[3,0],[2,0],[1,0]]
navigator = Map_navigator.new(0, 0, Image.load("images/navigator.png"), route)

Window.loop do
  break if Input.key_push?(K_ESCAPE)

  map.update
  map.draw

  navigaotr.update
  navigator.draw

end