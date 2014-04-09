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

    before { get :index }

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "should render the application template" do
      expect(response).to render_template("layouts/application")
    end
  end 

  describe "add_items" do
    describe "when the store item is not already on the receipt" do
      it "should create a new receipt item with the specified store item" do
        expect do
          post(:add_items, {item_ids: [store_item1.id], receipt: receipt.id, "store_item_price_#{store_item1.id}" => 1.0, "quantity_item_#{store_item1.id}" => 1, format: :js})
        end.to change {ReceiptItem.all().length}.by 1
      end

      it "should have a total variable that updates the view" do
        post(:add_items, {item_ids: [store_item1.id], receipt: receipt.id, "store_item_price_#{store_item1.id}" => 1.0, "quantity_item_#{store_item1.id}" => 1, format: :js})

        assigns(:total_added).should eq (1.0 * 1)
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

      it "should have a total variable that updates the view" do
        receipt.receipt_items << receipt_item1
        post(:add_items, {item_ids: [store_item1.id], receipt: receipt.id, "quantity_item_#{store_item1.id}" => 1, format: :js})
        assigns(:total_added).should eq (receipt_item1.price * 1)
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
