require_relative 'controller'

PORT = "COM3"

begin
    puts "starting..."
    controller= Controller.new(EV3::Brick.new(EV3::Connections::Bluetooth.new(PORT)))
    controller.connect()
    colors=[]
    controller.to_next(1)
    3.times do
        controller.to_next()
    end
    controller.left_turn()
    controller.to_next(1)
    controller.to_next()

    controller.left_turn()
    controller.to_next(1)
    3.times do
        controller.to_next()
    end
    
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