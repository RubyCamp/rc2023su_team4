class Map
  CHIP_SIZE = 320
  BULE_CHIP = 2
  GREEN_CHIP = 3
  RED_CHIP = 5 
  WHITE_CHIP = 6

  def initialize(map_data_path)
    @map_data = []
    #@map_data = instoll_data.each_slide(4).to_a #instoll_dataはev3からの一次元データ
    File.open(map_data_path) do |f|
      f.each do |line|
        @map_data << line.chomp.split(/\s*,\s*/)
      end
    end
    @bule_img = Image.load("images/bule.png")
    @green_img = Image.load("images/green.png")
    @red_img = Image.load("images/red.png")
    @white_img = Image.load("images/white.png")
  end

  def update
  end

  def draw
    @map_data.each_with_index do |line, my|
      line.each_with_index do |chip_num, mx|
        case chip_num.to_i
          when BULE_CHIP
            Window.draw(mx * CHIP_SIZE, my * CHIP_SIZE, @bule_img)
          when GREEN_CHIP
            Window.draw(mx * CHIP_SIZE, my * CHIP_SIZE, @green_img)
          when RED_CHIP
            Window.draw(mx * CHIP_SIZE, my * CHIP_SIZE, @red_img)
          when WHITE_CHIP
            Window.draw(mx * CHIP_SIZE, my * CHIP_SIZE, @white_img)
        end
      end
    end
  end
end