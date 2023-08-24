require_relative '../ruby-ev3/lib/communicator'
begin
  threads = []
  sender = Communicator::Sender.new("COM7")

  threads << Thread.start do
    message = 0x1111.to_s(16)
    puts "send: #{message}"
    sender.send(message)
  end

  threads.each{|t| t.join }
ensure
  sender.disconnect
end