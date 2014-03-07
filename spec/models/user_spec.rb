require 'spec_helper'

describe User do
  let! (:user) do
    FactoryGirl.create(:user)
  end

  subject{ user }

  describe "when email is not present" do
    before { user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { user.name = "a" * 21}
    it { should_not be_valid }
  end

  describe "when name is the right length" do
    before { user.name = "a" * 20 }
    it { should be_valid}
  end

  describe "when email is too long" do
    before { user.email = "a" * 45 + "@" + "a.com" }
    it { should_not be_valid}
  end

  describe "when email is the right length" do
    before { user.email = "a" * 44 + "@" + "a.com"}
    it { should be_valid }
  end
  
  describe "when email is the right length" do
    before { user.email = "a" * 44 + "@" + "a.com"}
    it { should be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com User@.d User]
      addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.com user@foo.org example.user@foo.com.au
                     foo@gmail.com foo@baz.com.jP]
      addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end
end
