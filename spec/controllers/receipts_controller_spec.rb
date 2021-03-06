require 'spec_helper'

describe ReceiptsController do

  let!(:receipt) { FactoryGirl.create(:receipt_with_items) }
  let!(:category) { FactoryGirl.create(:category) }
  let!(:store_item1) { FactoryGirl.create(:store_item) }
  let!(:store_item2) { FactoryGirl.create(:store_item) }
  let!(:receipt_item1) { FactoryGirl.create(:receipt_item, store_item: store_item1) }
  let!(:wrong_user) { FactoryGirl.create(:user) }

  before do 
    visit receipt_path(receipt)
  end

  describe "DELETE destroy" do
    before do
      controller.sign_in receipt.user
    end
    it "should delete the specified item from the database" do
      expect{delete :destroy, id: receipt.id}.to change{Receipt.all.length}.by -1
    end
  end

  describe "GET show" do
    describe "As the wrong user" do
      before do 
        controller.sign_in wrong_user
        get :show, {id: receipt.id}
      end

      it "should not render the receipt layout" do
        expect(response).not_to render_template("receipt")
        expect(response).to redirect_to(root_url)
      end
    end

    describe "As the correct user" do
      before do 
        controller.sign_in receipt.user
        get :show, {id: receipt.id}
      end

      it "should render the receipt layout" do
        expect(response).to render_template("receipt")
      end
    end
  end

  describe "GET index" do
    before do
      controller.sign_in receipt.user
      get :index 
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end
  end 

  describe "add_items" do
    before do
      controller.sign_in receipt.user
    end

    describe "when the store item is not already on the receipt" do
      it "should create a new receipt item with the specified store item" do
        expect do
          post(:add_items, {item_ids: [store_item1.id], receipt: receipt.id, "store_item_price_#{store_item1.id}" => 1.0, "quantity_item_#{store_item1.id}" => 1, format: :js})
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
end
