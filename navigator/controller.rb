require_relative '../ruby-ev3/lib/ev3'

class Controller
    LEFT_MOTOR = "C"
    RIGHT_MOTOR = "B"
    COLOR_SENSOR = "4"
    PORT = "COM3"
    HIGHER_SPEED = 24
    LOWER_SPEED=12
    MOTORS = [LEFT_MOTOR, RIGHT_MOTOR]

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

    def to_next(init_turn=true,first_count=0)
        count=first_count
        color=[]
        floor=0

        if count==0
            run_right_forward()
            while @brick.get_sensor(COLOR_SENSOR,2) == 1
            end
        elsif init_turn
            run_back do sleep 0.25 end
            left_rotate do
                sleep 0.5
            end
            run_right_forward()
        else
            left_rotate do
                sleep 0.25
            end
            run_right_forward()
        end


        loop do
            floor=@brick.get_sensor(COLOR_SENSOR,2)
            if floor == 1
                if count%2==0
                    left_rotate do sleep 0.8 end
                    run_right_forward()
                end
                count+=1
            else
                color << floor
            end

            if count>=2
                break
            end
        end
        return color[color.size/2]
    end

    def left_turn()
        run_back do sleep 0.6 end
        left_rotate do
            one=@brick.get_count(LEFT_MOTOR)
            @brick.speed(5,LEFT_MOTOR)
            while @brick.get_sensor(COLOR_SENSOR,2)!=1
            end
            puts @brick.get_count(LEFT_MOTOR)-one
        end
        run_back do sleep 0.25 end
    end

    def run_forward()
        @brick.start(HIGHER_SPEED,*MOTORS)
    end

    def run_right_forward()
        @brick.start(HIGHER_SPEED,*MOTORS)
        @brick.speed(LOWER_SPEED,RIGHT_MOTOR)
    end

    def run_back(&block)
        @brick.reverse_polarity(*MOTORS)
        @brick.start(HIGHER_SPEED,*MOTORS)
        yield
        @brick.stop(true,*MOTORS)
        @brick.reverse_polarity(*MOTORS)
    end    

    def run_back_velocity(velocity)
        @brick.reverse_polarity(*MOTORS)
        @brick.step_velocity(HIGHER_SPEED,velocity,velocity*0.25,*MOTORS)
        @brick.reverse_polarity(*MOTORS)
    end
    
    def left_rotate(&block)
        @brick.stop(true,*MOTORS)
        @brick.reverse_polarity(LEFT_MOTOR)
        @brick.start(LOWER_SPEED,*MOTORS)
        yield
        @brick.stop(true,*MOTORS)
        @brick.reverse_polarity(LEFT_MOTOR)
    end

    def close()
        @brick.stop(false, *MOTORS)
        @brick.clear_all
        @brick.disconnect
    end
end