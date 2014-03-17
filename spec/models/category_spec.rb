require 'spec_helper'

describe Category do

  let(:category) { FactoryGirl.create(:category) }

  subject{ category }

  it { should respond_to :name }
  
  it { should be_valid }

  describe "when name is not present" do
    before{ category.name = " " }
    it { should_not be_valid }
  end

  describe "when name is the right length" do
    before{ category.name = "a" * 50 }
    it { should be_valid }
  end

  describe "when name is too long" do
    before{ category.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "associated items destruction" do
    before{ FactoryGirl.create(:store_item, category: category) }

    it "should destroy associated items" do
      items = category.store_items.to_a
      category.destroy
      expect(items).not_to be_empty
      items.each do |itm|
        expect(StoreItem.where(id: itm.id)).to be_empty
      end
    end
  end

  describe "when name is already taken" do
    it "should not be valid" do
      expect(category.dup).not_to be_valid
    end
  end
end
