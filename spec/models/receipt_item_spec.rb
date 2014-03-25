require 'spec_helper'

describe ReceiptItem do
  let(:receipt_item) {FactoryGirl.build(:receipt_item)}

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

  describe "when saving the model" do
    it "should not allow the store_item_id to be changed" do
      receipt_item.save
      receipt_item.store_item_id = 12345
      receipt_item.save
      receipt_item.errors.messages[:store_item_id].should include("Change of receipt_item.store_item_id not allowed!")
    end
  end    
end


  
