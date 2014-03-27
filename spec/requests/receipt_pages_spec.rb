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
  end

  describe "Show" do
    before do 
      visit receipt_path(@receipt)
    end
    subject{ page }

    describe "should display the category modal", js: true do
      before { click_link "Add Item" }
      it "should display the modal" do
        page.should have_css('#selection-modal.in')
      end
    end
  end
end
