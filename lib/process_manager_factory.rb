class ProcessManagerFactory
  def initialize(bus)
    @process_managers = {}
    @bus = bus
    @bus.subscribe('order_placed', 'order_completed', self)
  end

  def any?
    @process_managers.any?
  end

  def count_by_type
    @process_managers.reduce(Hash.new(0)) do |h, (_k, v)|
      h[v.type] += 1
      h
    end.sort
  end

  def handle(message)
    correlation_id = message.correlation_id
    case message.type
    when 'order_placed'
      @process_managers[correlation_id] = if message.payload.dodgy
        DodgyProcessManager.new(@bus, correlation_id)
      else
        ProcessManager.new(@bus, correlation_id)
      end
    when 'order_completed'
      @process_managers.delete(correlation_id)
    end
  end
end

class ProcessManager
  attr_reader :type

  def initialize(bus, correlation_id)
    @type = 'Normal'
    @correlation_id = correlation_id
    @bus = bus
    @bus.subscribe_to_correlation_id(correlation_id, self)
    @food_cooked = false
  end

  def handle(message)
    case message.type
    when 'order_placed', 'cook_timed_out'
      return if @food_cooked
      @bus.publish(message.delayed_reply('cook_timed_out', 2))
      @bus.publish(message.reply('cook_food'))
    when 'order_cooked'
      @food_cooked = true
      @bus.publish(message.reply('price_order'))
    when 'order_priced'
      @bus.publish(message.reply('take_payment'))
    when 'order_paid'
      @bus.publish(message.reply('order_completed'))
      @bus.unsubscribe(self)
    end
  end
end

class DodgyProcessManager
  attr_reader :type

  def initialize(bus, correlation_id)
    @type = 'Dodgy'
    @correlation_id = correlation_id
    @bus = bus
    @bus.subscribe_to_correlation_id(correlation_id, self)
    @food_cooked = false
  end

  def handle(message)
    case message.type
    when 'order_placed'
      @bus.publish(message.reply('price_order'))
    when 'order_priced'
      @bus.publish(message.reply('take_payment'))
    when 'order_paid', 'cook_timed_out'
      return if @food_cooked
      @bus.publish(message.delayed_reply('cook_timed_out', 2))
      @bus.publish(message.reply('cook_food'))
    when 'order_cooked'
      @food_cooked = true
      @bus.publish(message.reply('order_completed'))
      @bus.unsubscribe(self)
    end
  end
end
