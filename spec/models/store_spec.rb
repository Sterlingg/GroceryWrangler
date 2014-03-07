require 'spec_helper'

describe Store do
  let(:store) {FactoryGirl.create(:store)}

  subject{ store }

  it { should respond_to :name }

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

end
