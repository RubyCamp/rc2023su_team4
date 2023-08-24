require_relative '../ruby_ev3/lib/communicator'
begin
  threads = []
  sender = Communicator::Sender.new("COM3")
  
  threads << Thread.start do
    message = 0x1f1f.to_s(16)
    puts "send: #{message}"
    sender.send(message)
  end

  threads.each{|t| t.join }
ensure
  sender.disconnect
end
