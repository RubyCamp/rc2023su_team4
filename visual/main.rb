require 'dxruby'
require_relative 'map'
require_relative 'map_navigator'
require_relative '../navigator/main'

Window.width = 1300
Window.height = 1000



route = [[3,2],[3,1],[3,0],[2,0],[1,0],[1,1],[1,2],[2,2],[2,1],[1,1],[0,1],[0,2],[1,2],[2,2],[3,2],[3,1],[3,0],[2,0],[1,0]]
navigator = Map_navigator.new(0, 0, Image.load("images/navigator.png"), route)

#test_colors = [6.0, 2.0, 5.0, 3.0, 6.0, 2.0, 6.0, 6.0, 6.0, 6.0, 6.0, 2.0] #nから受け取る一次元配列のsample
map = Map.new

colos=navigate()

Window.loop do
  break if Input.key_push?(K_ESCAPE)

  map.update
  map.draw

  search_completed = Input.key_push?(K_UP) # 本当は navigator.search_completed? とかで状態を取得する
  if search_completed
    map.update_map_data(colos)
  end

  moved = Input.key_push?(K_DOWN) #nから受け取る信号のsample
  navigator.update(moved)
  navigator.draw    

end