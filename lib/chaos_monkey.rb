class ChaosMonkey
  def initialize(next_handler)
    @next_handler = next_handler
  end

  def handle(message)
    chaos = rand(100)

    case chaos
    when 0 .. 10
      puts Rainbow("MESSAGE DROPPED MWAHAHAHA").bright.red
    when 85 .. 100
      puts Rainbow("BANANANANANA #{message.correlation_id}").bright.red
      @next_handler.handle(message)
      @next_handler.handle(message)
    else
      @next_handler.handle(message)
    end
  end
end
