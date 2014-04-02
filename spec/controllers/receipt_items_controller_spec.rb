require 'spec_helper'

describe ReceiptItemsController do

  let!(:store_item1) { FactoryGirl.create(:store_item) }
  let!(:receipt_item1) { FactoryGirl.create(:receipt_item, quantity: 2, price: 0, store_item: store_item1) }

  describe "PATCH update" do

    describe "when the item is valid" do
      before { xhr :patch, :update, :id => receipt_item1.id, :receipt_item => {quantity: 1, price: 8.95} }

      it "renders the update template" do
        expect(response).to render_template("update")
      end
      
      it "updates the quantity and price" do
        receipt_item1.reload
        expect(receipt_item1.quantity).to eq(1)
        expect(receipt_item1.price).to eq(8.95)
      end
    end

    describe "when the item is not valid" do
      before { xhr :patch, :update, :id => receipt_item1.id, :receipt_item => {quantity: 1, price: -10.00} }

      it "renders the update template" do
        expect(response).to render_template("update")
      end

      it "does not update the quantity and price" do
        receipt_item1.reload
        expect(receipt_item1.quantity).to eq(2)
        expect(receipt_item1.price).to eq(0)
      end
    end
  end 
end
