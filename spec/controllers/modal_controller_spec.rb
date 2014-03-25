require 'spec_helper'

describe ModalController do
  let!(:receipt) { FactoryGirl.create(:receipt_with_items) }
  let!(:store_item1) { FactoryGirl.create(:store_item) }
  let!(:store_item2) { FactoryGirl.create(:store_item) }
  let!(:receipt_item1) { FactoryGirl.create(:receipt_item, store_item: store_item1) }

  describe "add_items" do
    describe "when the store item is not already on the receipt" do
      it "should create a new receipt item with the specified store item" do
        expect do
          post(:add_items, {item_ids: [store_item1.id], receipt: receipt.id, "quantity_item_#{store_item1.id}" => 1, format: :js})
        end.to change {ReceiptItem.all().length}.by 1
      end
    end

    describe "when the store item is already on the receipt" do
      it "should create a new receipt item with the specified store item" do
        expect do
          receipt.receipt_items << receipt_item1
          post(:add_items, {item_ids: [store_item1.id], receipt: receipt.id, "quantity_item_#{store_item1.id}" => 1, format: :js})
        end.to change {ReceiptItem.all().length}.by 0
      end
      
      it "should increase the quantity of the item already on the receipt" do
        expect do
          receipt.receipt_items << receipt_item1
          post(:add_items, {item_ids: [store_item1.id], receipt: receipt.id, "quantity_item_#{store_item1.id}" => 1, format: :js})
        end.to change {ReceiptItem.find(receipt_item1).quantity}.by 1
      end
    end
  end

  describe "get_store_item" do
    describe "when store_item isn't on the Receipt'" do
      it "should return nil" do
        expect(controller.send(:get_receipt_item, nil, store_item1)).to be_nil
      end
    end

    describe "when store_item is on the Receipt" do
      it "should return the ReceiptItem" do
        receipt.receipt_items << receipt_item1
        expect(controller.send(:get_receipt_item, receipt, store_item1)).to eq receipt_item1
      end
    end

    describe "when Receipt is nil" do
      it "should return nil" do
        expect(controller.send(:get_receipt_item, nil, store_item1)).to be_nil
      end
    end
    describe "when StoreItem is nil" do
      it "should return nil" do
        expect(controller.send(:get_receipt_item, receipt, nil)).to be_nil
      end
    end
  end 
end