require_relative '../ruby-ev3/lib/ev3'

class Controller
    LEFT_MOTOR = "C"
    RIGHT_MOTOR = "B"
    COLOR_SENSOR = "4"
    PORT = "COM3"
    HIGHER_SPEED = 23
    LOWER_SPEED=12
    MOTORS = [LEFT_MOTOR, RIGHT_MOTOR]

    ON_RIGHT=0
    ON_LEFT=1

    @state=ON_LEFT
    @traveled=0

    def initialize(brick)
        @brick=brick
    end

    def connect()
        puts "connecting..."
        @brick.connect
        puts "connected..."
        # モーターの回転方向を初期化
        @brick.reset(*MOTORS)
    end

    def to_next()
        run_forward()
        count=0
        color=[]
        floor=0

        while @brick.get_sensor(COLOR_SENSOR,2) == 1
        end

        loop do
            floor=@brick.get_sensor(COLOR_SENSOR,2)
            if floor == 1
                if count%2==0
                    @brick.stop(true,LEFT_MOTOR)
                    sleep 1
                    run_forward()
                end
                count+=1
            else
                color << floor
            end

            if count>=2
                break
            end
        end
        return color.sum.fdiv(color.length).round
    end

    def run_forward()
        @brick.start(HIGHER_SPEED,*MOTORS)
        @brick.speed(LOWER_SPEED,RIGHT_MOTOR)
    end

    def close()
        @brick.stop(false, *MOTORS)
        @brick.clear_all
        @brick.disconnect
    end
end