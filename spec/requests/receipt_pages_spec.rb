require 'spec_helper'

describe "ReceiptPages" do
  describe "Index" do
    before{ visit receipts_path }
    
    subject{page}
    it { should have_title('Receipts') }
    it { should have_content('Receipts') }

    describe "the receipt container" do
      describe "when there is more than one receipt in the DB" do
        before do
          FactoryGirl.create(:receipt)
          visit receipts_path
          subject { page }
          it { should have_selector('div.row:nth-child(1) > div:nth-child(1) > div:nth-child(1) > a:nth-child(1) > span:nth-child(1)')}
        end
      end
    end
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
