require 'dxruby'
require_relative 'map'
#require_relative 'map_navigator'

Window.width = 1300
Window.height = 1000

map = Map.new("map_data/map_test.dat")

#navigator = Map_navigator.new(0, 0, Image.load("images/navigator.png"))

Window.loop do
  break if Input.key_push?(K_ESCAPE)

  map.update
  map.draw

  #navigaotr.update
  #navigator.draw

end