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

    def to_next(first_count=0)
        count=first_count
        color=[]
        floor=0

        if count==0
            run_right_forward()
            while @brick.get_sensor(COLOR_SENSOR,2) == 1
            end
        else
            run_back do sleep 0.5 end
            left_rotate do
                sleep 0.325
            end
            run_right_forward()
        end


        loop do
            floor=@brick.get_sensor(COLOR_SENSOR,2)
            if floor == 1
                if count%2==0
                    left_rotate do sleep 0.75 end
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
        return color.sum.fdiv(color.length).round
    end

    def left_turn()
        left_cut_back()
        #run_back do sleep 0.25 end
    end

    def left_cut_back()
        run_back do sleep 0.25 end
        @brick.stop(true,*MOTORS)
        left_rotate do 
            while @brick.get_sensor(COLOR_SENSOR,2)!=1
            end 
        end
        run_back do sleep 0.5 end
        left_rotate do 
            @brick.speed(HIGHER_SPEED*0.125,LEFT_MOTOR)
            while @brick.get_sensor(COLOR_SENSOR,2)!=1
            end 
        end
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