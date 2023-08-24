require_relative 'controller'

PORT = "COM7"
COLOR_SENSOR = "4"

begin
    puts "starting..."
    brick=EV3::Brick.new(EV3::Connections::Bluetooth.new(PORT))
    brick.connect()
    brick.step_velocity(360,25,100,"B","C")
    puts
rescue
    p $!
  # 終了処理は必ず実行する
ensure
    puts "closing..."
    brick.clear_all
    brick.disconnect
    puts "finished..."
end