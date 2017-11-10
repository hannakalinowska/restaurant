class ChaosMonkey
  def self.record(type)
    report[type] += 1
  end

  def self.report
    @report ||= Hash.new(0)
  end

  def initialize(next_handler)
    @next_handler = next_handler
  end

  def handle(message)
    chaos = rand(100)

    case chaos
    when 0 .. 10
      self.class.record(:dropped)
    when 85 .. 100
      self.class.record(:duplicates)
      @next_handler.handle(message)
      @next_handler.handle(message)
    else
      @next_handler.handle(message)
    end
  end
end
