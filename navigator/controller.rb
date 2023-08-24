require_relative '../ruby-ev3/lib/ev3'

class Controller
    LEFT_MOTOR = "C"
    RIGHT_MOTOR = "B"
    COLOR_SENSOR = "4"
    PORT = "COM3"
    HIGHER_SPEED = 20
    LOWER_SPEED=10
    MOTORS = [LEFT_MOTOR, RIGHT_MOTOR]
    INIT_TURN_TIME=1.075

    def initialize(brick)
        @brick=brick
        @turn_time=INIT_TURN_TIME
        @interval=0
    end

    def connect()
        puts "connecting..."
        @brick.connect
        puts "connected..."
        # モーターの回転方向を初期化
        @brick.reset(*MOTORS)
    end

    def to_next(init_turn=0,first_count=0)
        count=first_count
        color=[]
        floor=0

        if count==0
            run_right_forward()
            while @brick.get_sensor(COLOR_SENSOR,2) == 1
            end
        elsif init_turn==0
            run_back do sleep 0.75 end
            left_rotate do
                sleep 0.5
            end
            run_right_forward()
        elsif init_turn==1
            left_rotate do
                sleep 0.25
            end
            run_right_forward()
        elsif init_turn==2
            run_right_forward()
        end


        loop do
            floor=@brick.get_sensor(COLOR_SENSOR,2)
            if floor == 1
                if count%2==0
                    left_rotate do
                        sleep @turn_time 
                    end
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
        return color[color.length/2]
    end

    def left_turn()
        run_back do sleep 0.4 end
        old=@brick.get_count(RIGHT_MOTOR)
        left_rotate do
            @brick.speed(5,LEFT_MOTOR)
            while @brick.get_sensor(COLOR_SENSOR,2)!=1
            end
        end

        rotation=@brick.get_count(RIGHT_MOTOR)-old

        puts "左転回：" +rotation.to_s()
        @turn_time=INIT_TURN_TIME

        if rotation>280
            right_rotate do sleep 0.5 end

            run_back do
                @brick.speed(5,RIGHT_MOTOR)
                sleep 0.5
            end 
        elsif rotation>240
            right_rotate do sleep 0.4 end

            run_back do
                @brick.speed(5,RIGHT_MOTOR)
                sleep 0.25
            end
        elsif rotation<90
            run_back do sleep 0.5 end
            left_rotate do
                @brick.stop(true,LEFT_MOTOR)
                while @brick.get_sensor(COLOR_SENSOR,2)!=1
                end
            end
        elsif rotation<120
            run_back do sleep 0.4 end
            left_rotate do
                @brick.speed(2,LEFT_MOTOR)
                while @brick.get_sensor(COLOR_SENSOR,2)!=1
                end
            end     
        elsif rotation<180
            run_back do sleep 0.3 end
            left_rotate do
                @brick.speed(2,LEFT_MOTOR)
                while @brick.get_sensor(COLOR_SENSOR,2)!=1
                end
            end
        end

        to_next(2,1)
    end

    def run_forward(&block)
        @brick.start(HIGHER_SPEED,*MOTORS)
        yield
        @brick.stop(true,*MOTORS)
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

    def right_rotate(&block)
        @brick.stop(true,*MOTORS)
        @brick.reverse_polarity(RIGHT_MOTOR)
        @brick.start(LOWER_SPEED,*MOTORS)
        yield
        @brick.stop(true,*MOTORS)
        @brick.reverse_polarity(RIGHT_MOTOR)
    end

    def close()
        @brick.stop(false, *MOTORS)
        @brick.clear_all
        @brick.disconnect
    end
end