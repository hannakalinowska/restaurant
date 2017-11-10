class ProcessManagerFactory
  def initialize(bus)
    @process_managers = {}
    @bus = bus
    @bus.subscribe('order_placed', 'order_paid', self)
  end

  def count
    @process_managers.count
  end

  def handle(message)
    correlation_id = message.correlation_id
    case message.type
    when 'order_placed'
      @process_managers[correlation_id] = ProcessManager.new(@bus, correlation_id)
    when 'order_paid'
      @process_managers.delete(correlation_id)
    end
  end
end

class ProcessManager
  def initialize(bus, correlation_id)
    @correlation_id = correlation_id
    @bus = bus
    @bus.subscribe_to_correlation_id(correlation_id, self)
  end

  def handle(message)
    case message.type
    when 'order_placed'
      @bus.publish(message.reply('cook_food'))
    when 'order_cooked'
      @bus.publish(message.reply('price_order'))
    when 'order_priced'
      @bus.publish(message.reply('take_payment'))
    when 'order_paid'
      @bus.unsubscribe(self)
    end
  end
end
