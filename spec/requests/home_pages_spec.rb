require 'spec_helper'

describe "UserPages" do
  describe "Index" do
    before{visit root_path}

    it "should have the content Receipts" do
      expect(page).to have_content('Receipts')
    end

    it "should have the content Price Trends" do
      expect(page).to have_content('Price Trends')
    end

    it "should have the content Recipes" do
      expect(page).to have_content('Recipes')
    end

    it "should have the content Login" do
      expect(page).to have_content('Login')
    end
    it "should have an input box for a username" do
      expect(page).to have_css('input[type="text"]')
    end

    it "should have an input box for the password" do
      expect(page).to have_css('input[type="password"]')
    end
  end
end
