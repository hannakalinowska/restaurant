require 'json'
require 'securerandom'

class Order
  attr_reader :data

  def initialize(data = {})
    @data = data.merge('number' => SecureRandom.uuid[0 .. 7])
  end

  def add_line_item(name:, quantity: 1, price: nil, attrs: {})
    @data['line_items'] ||= {}

    uuid = SecureRandom.uuid[0 .. 7]
    @data['line_items'][uuid] = { 'name' => name, 'quantity' => quantity, 'price' => price }.merge(attrs)

    uuid
  end

  def update_line_item(uuid, attrs)
    @data['line_items'][uuid].merge!(attrs)
  end

  def to_json
    @data.to_json
  end

  def method_missing(m, *args, &block)
    if m.match(/=$/)
      @data[m[0 .. -2]] = args.shift
    else
      @data[m.to_s]
    end
  end
end
