require 'spec_helper'

describe User do
  let!(:user){ FactoryGirl.build(:user) }

  subject{ user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should respond_to(:authenticate) }


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
    it { should be_valid }
  end

  describe "when email is too long" do
    before { user.email = "a" * 45 + "@" + "a.com" }
    it { should_not be_valid }
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

  describe "associated receipts destruction" do
    before{ FactoryGirl.create(:receipt, user: user) }

    it "should destroy associated receipts" do
      receipts = user.receipts.to_a
      user.destroy
      expect(receipts).not_to be_empty
      receipts.each do |receipt|
        expect(Receipt.where(id: receipt.id)).to be_empty
      end
    end
  end

  describe "when email address is already taken" do
    it "should not be valid" do
      user.save
      expect(user.dup).not_to be_valid
    end
  end

  describe "when the password is blank" do
    before do
      user.password = ""
      user.password_confirmation = ""
    end
    it "should not be valid" do
      expect(user).not_to be_valid
    end
  end

  describe "when the password is present and valid" do
    before do
      user.password = "wowsuchpassword1"
      user.password_confirmation = "wowsuchpassword1"
    end
    it "should not be valid" do
      expect(user).to be_valid
    end
  end

  describe "when the password's length is too short'" do
    before do
      user.password = "wow"
      user.password_confirmation = "wow"
    end
    it "should not be valid" do
      expect(user).not_to be_valid
    end
  end
end
