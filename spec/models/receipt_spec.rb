require 'spec_helper'

describe Receipt do
  let(:receipt){ FactoryGirl.create(:receipt) }

  subject{ receipt }

  it { should respond_to(:date_purchased) }
  it { should respond_to(:notes) }
  it { should respond_to(:total) }
  it { should respond_to(:store_id) }
  it { should respond_to(:user_id) }

  it{ should be_valid }

  describe "when notes the right length" do
    before { receipt.notes = "a" * 2000}
    it { should be_valid }
  end

  describe "when notes too long" do
    before { receipt.notes = "a" * 2001}
    it { should_not be_valid }
  end

  describe "when total is negative" do
    before { receipt.total = -12.5 }
    it { should_not be_valid }
  end

  describe "when total is not too large" do
    before { receipt.total = 10000000 }
    it { should be_valid }
  end

  describe "when total is too large" do
    before { receipt.total = 10000001 }
    it { should_not be_valid }
  end

  describe "associated items destruction" do
    before{ FactoryGirl.create(:receipt_item, receipt: receipt) }

    it "should destroy associated items" do
      items = receipt.receipt_items.to_a
      receipt.destroy
      expect(items).not_to be_empty
      items.each do |itm|
        expect(ReceiptItem.where(id: itm.id)).to be_empty
      end
    end
  end
end
