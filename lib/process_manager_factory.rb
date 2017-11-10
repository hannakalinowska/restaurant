class ProcessManagerFactory
  def initialize(bus)
    @process_managers = {}
    @bus = bus
  end

  def handle(message)
    correlation_id = message.correlation_id
    @process_managers[correlation_id] = ProcessManager.new(@bus, correlation_id)
  end
end

class ProcessManager
  def initialize(bus, correlation_id)
    @correlation_id = correlation_id
    @bus = bus
    @bus.subscribe_to_correlation_id(correlation_id, self)
  end

  def handle(message)
    puts "Got your order! #{message.type}"
  end
end
