require_relative 'controller'

PORT = "COM3"
COLOR_SENSOR = "4"

begin
    puts "starting..."
    brick=EV3::Brick.new(EV3::Connections::Bluetooth.new(PORT))
    brick.connect()
    10.times do
        puts brick.get_sensor(COLOR_SENSOR,2)
        sleep 1
    end
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