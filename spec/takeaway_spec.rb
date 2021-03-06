require 'takeaway'

describe Takeaway do
  let(:menu_instance) {double :menu_instance}
  let(:order_class) {double(:order_class, new: order_instance)}
  let(:order_instance) {double :order_instance}
  let(:messenger_instance) {double :messenger_instance}
  let(:dish) {double :dish}
  let(:dish_2) {double :dish_2}
  let(:text_message) {double :text_message}
  subject {described_class.new(menu_instance, order_class, messenger_instance)}

  it{is_expected.to respond_to(:read_menu)}
  it{is_expected.to respond_to(:order)}
  it{is_expected.to respond_to(:basket)}
  it{is_expected.to respond_to(:summary)}
  it{is_expected.to respond_to(:confirm)}

  it 'should be able to read a menu' do
    allow(menu_instance).to receive(:new).and_return(menu_instance)
    expect(menu_instance).to receive(:read).and_return(menu_instance)
    subject.read_menu
  end
  it 'should be able to place an order' do
    allow(order_instance).to receive(:select).and_return(dish)
    expect(subject.order(dish)).to eq(dish)
  end
  it 'should be able to call the order basket' do
      allow(order_instance).to receive(:basket).and_return(dish)
      expect(subject.basket).to eq(dish)
  end
  it 'should be able to call the order summary' do
    allow(order_instance).to receive(:summary).and_return(dish)
    expect(subject.summary).to eq(dish)
  end
  it 'should be able to call the messenger confirm method' do
    expect(messenger_instance).to receive(:confirm).and_return(text_message)
    allow(order_instance).to receive(:new)
    (subject.confirm)
  end
  it 'should reset the current order/basket to empty' do
    expect(messenger_instance).to receive(:confirm)
    allow(order_instance).to receive(:select).and_return(dish)
    subject.order(dish)
    expect(order_class).to receive(:new)
    subject.confirm
  end
end
