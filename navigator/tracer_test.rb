require_relative 'controller'
require_relative '../ruby-ev3/lib/ev3/commands/load_commands'

PORT = "COM7"

begin
    puts "starting..."
    controller= Controller.new(EV3::Brick.new(EV3::Connections::Bluetooth.new(PORT)))
    controller.connect()
    colors=[]
    # controller.rotate_right_90_degrees()
    # controller.back()


    controller.front()
    controller.front()
    controller.rotate_left_90_degrees()
    # controller.rotate_right_90_degrees()
    controller.front()
    controller.front()
    controller.rotate_left_90_degrees()
    controller.front()
    controller.front()


    # controller.reverse_polarity()
    # controller.run_forward(RIGHT_MOTOR)
    # controller.right_turn()
    # controller.right_angle2()
    # controller.left_turn()
    # controller.right_turn()
    # colors<< controller.to_next(1,1)
    # colors<< controller.to_next()
    # colors<< controller.to_next()
    # controller.left_turn()
    # controller.to_next(2,1)
    # colors<< controller.to_next()
    # colors<< controller.to_next()
    # controller.left_turn()
    # controller.to_next(2,1)
    # colors<< controller.to_next()
    # colors<< controller.to_next()
    # controller.left_turn()
    # controller.to_next(2,1)
    # colors<< controller.to_next()
    # colors<< controller.to_next()

    # print colors
rescue
    p $!
  # 終了処理は必ず実行する
ensure
    puts "closing..."
    controller.close()
    puts "finished..."
end