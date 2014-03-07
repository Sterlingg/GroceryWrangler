require 'spec_helper'

describe Item do
  let(:item) {FactoryGirl.create(:item)}

  subject{ item }

  it{ should respond_to :name }
  it{ should respond_to :description }
  it{ should respond_to :upc }
  it{ should respond_to :price }
  it{ should respond_to :weight }
  it{ should respond_to :volume }
  it{ should respond_to :category_id }
  it{ should respond_to :receipt_id }

  it { should be_valid }

  describe "when name is blank" do
    before { item.name = " " }
    it { should_not be_valid }
  end

  describe "when price is negative" do
    before { item.price = -12.5 }
    it { should_not be_valid }
  end

  describe "when price is the right size" do
    before { item.price = 10000000 }
    it { should be_valid }
  end

  describe "when price is too high" do
    before { item.price = 10000001 }
    it { should_not be_valid }
  end
  
  describe "when weight is negative" do
    before { item.weight = -12.5 }
    it { should_not be_valid }
  end

  describe "when weight is the right size" do
    before { item.weight = 10000000 }
    it { should be_valid }
  end

  describe "when weight is too high" do
    before { item.weight = 10000001 }
    it { should_not be_valid }
  end

  describe "when volume is negative" do
    before { item.volume = -12.5 }
    it { should_not be_valid }
  end

  describe "when volume is the right size" do
    before { item.volume = 10000000 }
    it { should be_valid }
  end

  describe "when volume is too high" do
    before { item.volume = 10000001 }
    it { should_not be_valid }
  end

end
