require 'spec_helper'

describe "ReceiptPages" do

  before { @receipt = FactoryGirl.create(:receipt_with_items) }
  describe "Index" do
    before do 
      visit receipts_path 
    end

    subject{page}

    it { should have_title('Receipts') }
    it { should have_content('Receipts') }

    describe "the receipt container" do
      describe "when there is more than one receipt in the DB" do
        before do
          visit receipts_path
          subject { page }
          it { should have_selector('div.row:nth-child(1) > div:nth-child(1) > div:nth-child(1) > a:nth-child(1) > span:nth-child(1)')}
        end
      end
    end
  end

  describe "Show" do
    before do 

      # @category = FactoryGirl.create(:category)
      # @store = FactoryGirl.create(:store)

      # @store_item = FactoryGirl.create(:store_item, upc: 123456789101, price: 8.95, weight: 0.01, volume: 0.12, name: 'Spaghetti', category: @category, store: @store)
      # FactoryGirl.create(:receipt_item, store_item: @store_item, receipt: @receipt)

      visit receipt_path(@receipt)
    end
    subject{ page }
    
    it { should have_content 'Name' }
    it { should have_content 'Category' }
    it { should have_content 'Quantity' }
    it { should have_content 'Weight' }
    it { should have_content 'Volume' }
    it { should have_content 'Price' }
    it { should have_content 'Add Item' }
    it { should have_css '#add-item-btn' }
    it { should have_content @receipt.total }
    it { should have_content @receipt.receipt_items.first.store_item }

    describe "modal should not be displayed" do
      it { should_not have_css('#selection-modal.in') }
      it { should_not have_css('body.modal-open') }
    end

    describe "should display the category modal", js: true do
      before { click_link "Add Item" }
      it "should display the modal" do
        page.should have_css('#selection-modal.in')
      end
      it "should dim the page" do
        page.should have_css('body.modal-open') 
      end
    end
  end
end
