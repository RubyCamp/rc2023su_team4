begin
  threads = []
  sender = Communicator::Sender.new

  threads << Thread.start do
    message = val.to_s(16)
    puts "send: #{message}"
    sender.send(message)
  end

  threads.each{|t| t.join }
ensure
  sender.disconnect
end