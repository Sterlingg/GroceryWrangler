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
    before{ FactoryGirl.create(:item, category: category) }

    it "should destroy associated items" do
      items = category.items.to_a
      category.destroy
      expect(items).not_to be_empty
      items.each do |itm|
        expect(Item.where(id: itm.id)).to be_empty
      end
    end
  end

end
