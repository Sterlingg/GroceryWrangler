require 'spec_helper'

describe 'receipts/show.html.erb' do
  context 'when there is a receipt' do
    before do
      @receipt = FactoryGirl.build(:receipt_with_items)
      assign(:receipt, @receipt)
    end

    subject{ render }

    it { should have_content 'Name' }
    it { should have_content 'Category' }
    it { should have_content 'Quantity' }
    it { should have_content 'Weight' }
    it { should have_content 'Volume' }
    it { should have_content 'Price' }
    it { should have_content 'Add Item' }
    it { should have_css '#add-item-btn' }
    it { should have_content @receipt.total }

    describe "modal should not be displayed" do
      it { should_not have_css('#selection-modal.in') }
      it { should_not have_css('body.modal-open') }
    end
  end
end
