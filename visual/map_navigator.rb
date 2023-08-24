class Map_navigator
  CHIP_SIZE = 320
  
  def initialize(x, y, img, route)
    @x = x
    @y = y
    @img = img
    @route = route
    @count = 0
  end
  
  def update(moved) #movedは動いたというNからの信号
    @x = @route[@count][0]
    @y = @route[@count][1]
    if moved
      @count += 1
    end
  end
  
  def draw
    Window.draw(@x * CHIP_SIZE, @y * CHIP_SIZE, @img)
  end
end