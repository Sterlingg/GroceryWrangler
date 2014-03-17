require 'spec_helper'

describe StoreItem do
  let(:store_item) {FactoryGirl.create(:store_item)}

  subject{ store_item }

  it{ should respond_to :name }
  it{ should respond_to :description }
  it{ should respond_to :upc }
  it{ should respond_to :price }
  it{ should respond_to :weight }
  it{ should respond_to :volume }
  it{ should respond_to :category_id }
  it{ should respond_to :store_id }

  it { should be_valid }

  describe "when name is blank" do
    before { store_item.name = " " }
    it { should_not be_valid }
  end

  describe "when price is negative" do
    before { store_item.price = -12.5 }
    it { should_not be_valid }
  end

  describe "when price is the right size" do
    before { store_item.price = 10000000 }
    it { should be_valid }
  end

  describe "when price is too high" do
    before { store_item.price = 10000001 }
    it { should_not be_valid }
  end
  
  describe "when weight is negative" do
    before { store_item.weight = -12.5 }
    it { should_not be_valid }
  end

  describe "when weight is the right size" do
    before { store_item.weight = 10000000 }
    it { should be_valid }
  end

  describe "when weight is too high" do
    before { store_item.weight = 10000001 }
    it { should_not be_valid }
  end

  describe "when volume is negative" do
    before { store_item.volume = -12.5 }
    it { should_not be_valid }
  end

  describe "when volume is the right size" do
    before { store_item.volume = 10000000 }
    it { should be_valid }
  end

  describe "when volume is too high" do
    before { store_item.volume = 10000001 }
    it { should_not be_valid }
  end

  describe "associated items destruction" do
    before{ FactoryGirl.create(:receipt_item, store_item: store_item) }

    it "should destroy associated items" do
      store_receipt_items = store_item.receipt_items.to_a
      store_item.destroy
      expect(store_receipt_items).not_to be_empty
      store_receipt_items.each do |itm|
        expect(ReceiptItem.where(id: itm.id)).to be_empty
      end
    end
  end
end
