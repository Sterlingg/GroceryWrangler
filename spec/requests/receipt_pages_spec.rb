require 'spec_helper'

describe "ReceiptPages" do
  describe "Index" do
    before{visit receipts_path}

    it "should have the title Receipts" do
      expect(page).to have_title('Receipts')
    end

    it "should have the content Receipts" do
      expect(page).to have_content('Receipts')
    end

    it "should have a image to add receipts" do
      page.should have_selector("img[src$='assets/add_receipt.png']")
    end
  end
end
