require_relative 'controller'

PORT = "COM3"

begin
    puts "starting..."
    controller= Controller.new(EV3::Brick.new(EV3::Connections::Bluetooth.new(PORT)))
    controller.connect()
    colors=[]
    colors<< controller.to_next(true,1)
    colors<< controller.to_next()
    colors<< controller.to_next()
    controller.left_turn()
    controller.to_next(false,1)
    colors<< controller.to_next()
    colors<< controller.to_next()
    controller.left_turn()
    controller.to_next(false,1)
    colors<< controller.to_next()
    colors<< controller.to_next()

    print colors
rescue
    p $!
  # 終了処理は必ず実行する
ensure
    puts "closing..."
    controller.close()
    puts "finished..."
end