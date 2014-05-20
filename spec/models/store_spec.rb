require 'spec_helper'

describe Store do
  let(:store) {FactoryGirl.create(:store)}

  subject{ store }

  it { should respond_to :name }
  it { should respond_to :city }

  describe "should not be blank" do
    before{ store.name = " " }
    it{ should_not be_valid }
  end

  describe "when name is too long" do
    before { store.name = "a" * 51}
    it { should_not be_valid }
  end

  describe "when name is the right length" do
    before { store.name = "a" * 50 }
    it { should be_valid}
  end

  describe "associated receipts destruction" do
    before{ FactoryGirl.create(:receipt, store: store) }

    it "should destroy associated receipts" do
      receipts = store.receipts.to_a
      store.destroy
      expect(receipts).not_to be_empty
      receipts.each do |receipt|
        expect(Receipt.where(id: receipt.id)).to be_empty
      end
    end
  end
end
