require 'spec_helper'

describe "UserPages" do
  describe "Index" do
    before{visit root_path}

    it "should have the right links on the layout" do
      visit root_path

      click_link "Receipts"
      expect(page).to have_title('Receipts')

      click_link "Recipes"
      expect(page).to have_title('Recipes')

      click_link "Price Trends"
      expect(page).to have_title('Price Trends')

      click_link "Budgeting"
      expect(page).to have_title('Budgeting')
    end

    it "should have an input box for a username" do
      expect(page).to have_css('input[type="text"]')
    end
    
    it  "should have an input box for the password" do
      expect(page).to have_css('input[type="password"]')
    end
  end
end
