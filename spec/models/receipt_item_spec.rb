require 'spec_helper'

describe ReceiptItem do
  let(:receipt_item) {FactoryGirl.create(:receipt_item)}

  subject{ receipt_item }

  it{ should respond_to :price }
  it{ should respond_to :quantity }
  it{ should respond_to :store_item_id }

  it { should be_valid }

  describe "when price is negative" do
    before { receipt_item.price = -12.5 }
    it { should_not be_valid }
  end

  describe "when price is the right size" do
    before { receipt_item.price = 10000000 }
    it { should be_valid }
  end

  describe "when price is too high" do
    before { receipt_item.price = 10000001 }
    it { should_not be_valid }
  end
end
        
