require 'spec_helper'

describe ReceiptsController do

    let!(:receipt) { FactoryGirl.create(:receipt) }
    let!(:category) { FactoryGirl.create(:category) }

    before do 
      store_item = FactoryGirl.create(:store_item, upc: 123456789101, price: 8.95, weight: 0.01, volume: 0.12, name: 'Spaghetti', category: category)
      FactoryGirl.create(:receipt_item, store_item: store_item, receipt: receipt)

      visit receipt_path(receipt)
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
end
