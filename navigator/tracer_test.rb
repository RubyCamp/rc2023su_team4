require_relative 'controller'

PORT = "COM3"

begin
    puts "starting..."
    controller= Controller.new(EV3::Brick.new(EV3::Connections::Bluetooth.new(PORT)))
    controller.connect()
    colors=[]
    4.times do
        colors<< controller.to_next()
    end
    controller.left_turn()
    print colors
    puts
rescue
    p $!
  # 終了処理は必ず実行する
ensure
    puts "closing..."
    controller.close()
    puts "finished..."
end