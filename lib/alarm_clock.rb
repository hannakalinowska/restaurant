class AlarmClock
  def initialize(bus)
    @bus = bus
    @messages = []
  end

  def handle(message)
    @messages << message
  end

  def start
    Thread.new do
      loop do
        messages = @messages.select { |m| m.publish_at < Time.now }
        messages.each do |message|
          @bus.publish(message.payload)
        end
        @messages -= messages
        sleep 1
      end
    end
  end
end
