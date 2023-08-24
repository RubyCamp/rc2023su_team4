require_relative 'controller'

PORT = "COM3"

def navigate()
    begin
        puts "starting..."
        controller= Controller.new(EV3::Brick.new(EV3::Connections::Bluetooth.new(PORT)))
        controller.connect()
        colors=Array.new(12)
        colors[11] = controller.to_next(1,1)
        colors[7]  = controller.to_next()
        colors[3]  = controller.to_next()
        
        controller.left_turn()
        colors[2]  = controller.to_next()
        colors[1]  = controller.to_next()
        
        controller.left_turn()
        colors[5]  = controller.to_next()
        colors[9]  = controller.to_next()
        
        controller.left_turn()
        colors[10] = controller.to_next()
        
        controller.left_turn()
        controller.to_next()
        
        controller.left_turn()
        colors[6]  = controller.to_next()
        colors[4]  = controller.to_next()
        
        controller.left_turn()
        colors[8]  = controller.to_next()
        
        controller.left_turn()
        controller.to_next()
        controller.to_next()
        controller.to_next()
        
        controller.left_turn()
        controller.to_next()
        controller.to_next()
        
        controller.left_turn()
        controller.to_next()
        controller.to_next()
        
        colors[0]=6.0
        
        output=[]
        colors.each do |item|
            output<< item.to_i
        end
        print output

        controller.run_back do
            sleep 1
        end
        controller.left_rotate do
            sleep 1.5
        end
        controller.run_back do
            sleep 3
        end

    rescue
        p $!
    # 終了処理は必ず実行する
    ensure
        puts "closing..."
        controller.close()
        puts "finished..."

        return output
    end
end

navigate()