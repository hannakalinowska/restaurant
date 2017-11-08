require 'order'

RSpec.describe Order do
  let(:data) { { 'number' => 5 } }
  let(:order) { Order.new(data) }

  it 'fetches a value' do
    expect(order.number).to eq(5)
  end

  it 'sets a value' do
    expect { order.number = 6 }.to_not raise_error
    expect(order.number).to eq(6)
  end

  it 'duplicate object' do
    copy_order = order.dup
    expect(copy_order.number).to eq(5)
  end

  it 'add line items' do
    uuid = order.add_line_item(name: 'Pizza', quantity: 30)
    expect(order.line_items[uuid]).to match hash_including({
      'name' => 'Pizza',
      'quantity' => 30,
      'price' => nil
    })
  end

  it 'updates line item' do
    uuid = order.add_line_item(name: 'Pizza', quantity: 30)
    order.update_line_item(uuid, 'price' => 10)
    expect(order.line_items[uuid]).to match hash_including({
      'name' => 'Pizza',
      'quantity' => 30,
      'price' => 10
    })
  end
end
