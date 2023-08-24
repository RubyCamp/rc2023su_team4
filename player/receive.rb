begin
  threads = []
  receiver = Communicator::Receiver.new("COM7")

  threads << Thread.start do
    signals = receiver.receive
    message = receiver.get_message(signals)
  end

  threads.each{|t| t.join }
ensure
  receiver.disconnect
end
