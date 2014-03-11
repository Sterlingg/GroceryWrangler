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

  describe "Show" do
    let!(:receipt) { FactoryGirl.create(:receipt) }
    let!(:category) { FactoryGirl.create(:category) }
    before do 
      FactoryGirl.create(:item, receipt: receipt, upc: 123456789101, price: 8.95, weight: 0.01, volume: 0.12, name: 'Spaghetti', category: category)
      visit receipt_path(receipt)
end
    subject{ page }
    
    it { should have_content 'Name' }
    it { should have_content 'Category' }
    it { should have_content 'Weight' }
    it { should have_content 'Volume' }
    it { should have_content 'Price' }
    it { should have_content 'Add Item' }
    it { should have_content receipt.total }
    it { should have_content receipt.items.first.name }
    it { should have_content receipt.items.first.category.name }
    it { should have_content receipt.items.first.weight }
    it { should have_content receipt.items.first.volume }
    
  end
end
