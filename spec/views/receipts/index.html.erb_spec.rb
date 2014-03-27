require 'spec_helper'

describe 'receipts/index.html.erb' do
  context 'when there is a receipt' do
    before do
      @receipt =FactoryGirl.build(:receipt)
      assign(:receipts, [@receipt])

    end

    subject{ render }
    it { should have_content @receipt.store.name}
  end
end
