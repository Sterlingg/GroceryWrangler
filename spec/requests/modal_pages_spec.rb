require 'spec_helper'

describe "ModalPages" do
  before do
    @receipt = FactoryGirl.create(:receipt)
    visit receipt_path(@receipt)
  end

  describe "Page elements are in place" do
    it "has the modal on the page" do
      expect(page).to have_selector "#selection-modal"
      expect(page).to have_selector ".modal-body"
    end
  end

  describe "Category Selection", js: true do
    before { @category = FactoryGirl.create(:category) }

    describe "with multiple categories" do
      before do
        @category1 = FactoryGirl.create(:category)
        click_link "Add Item"
      end

      it "should display the categories" do
        within(".modal-body") do
          expect(page).to have_link(@category.name, href: modal_item_selection_path(category: @category, receipt: @receipt))
          expect(page).to have_link(@category1.name, href: modal_item_selection_path(category: @category1, receipt: @receipt))
        end
      end
    end

    describe "when a category is selected" do
      before do
        click_link "Add Item"
        click_link @category.name
      end

      it "should display the items in that category" do 
        within(".modal-body") do
          @category.store_items.each do |item|
            expect(page).to have_content item.name
          end
        end
      end
    end

    describe "Item Selection" do
      before do
        @category = FactoryGirl.create(:category)
        @store_item1 = FactoryGirl.create(:store_item)
        @store_item2 = FactoryGirl.create(:store_item)

        click_link "Add Item"
      end

      describe "the form layout", js:true do
        before { @category.store_items << @store_item1 }

        describe "With one item" do
          before {click_link @category.name}

          it "should have a checkbox" do
            expect(page).to have_selector("#item_id_#{@store_item1.id}")
          end

          it "should have a quantity selector" do
            expect(page).to have_selector("select")
          end

          it "should have an input for the price" do
            expect(page).to have_selector('input[type="text"]')
          end          

          describe "the table header" do
            it "should have a price header" do
              within(".modal-body") do
                expect(page).to have_content('Price')
              end
            end

            it "should have a quantity header" do
              within(".modal-body") do
                expect(page).to have_content('Quantity')
              end
            end

            it "should have a name header" do
              within(".modal-body") do
                expect(page).to have_content('Name')
              end
            end
          end
        end
      end

      describe "when there are 2 items to select from", js: true do
        before do 
          @category.store_items << @store_item1
          @category.store_items << @store_item2
          click_link @category.name
        end

        it "should have 2 checkboxes" do
          expect(page).to have_selector("#item_id_#{@store_item1.id}")
          expect(page).to have_selector("#item_id_#{@store_item2.id}")
        end

        it "should have a button to add the items to the receipt" do
          expect(page.find(".modal-body")).to have_css('input[type="submit"]')
        end

        describe "when the add button is clicked" do

          describe "when one item is checked" do
            before {check "item_id_#{@store_item1.id}"}

            describe "when the item is already on the receipt" do
              before do
                @receipt_item = FactoryGirl.create(:receipt_item, store_item: @store_item1)
                @receipt = @receipt
                @receipt.receipt_items << @receipt_item
                visit receipt_path(@receipt)
                click_link "Add Item"
                click_link @category.name
                check "item_id_#{@store_item1.id}"
              end

              it "should not add another item to the receipt" do
                expect(page).to have_xpath('//*[@id="receipts-table"]//tr', count: 2)
                click_button 'modal-add-items'
                visit receipt_path(@receipt)
                expect(page).to have_xpath('//*[@id="receipts-table"]//tr', count: 2)
              end
            end

            it "should add a new receipt item to the receipt" do
              # TODO: expect .. change wasn't working in this test?'
              expect(@receipt.receipt_items.length).to eq 0
              fill_in("store_item_price_#{@store_item1.id}", with: '1.00')
              click_button 'modal-add-items'
              expect(@receipt.reload.receipt_items.length).to eq 1
              expect(@receipt.reload.receipt_items.first.price).to eq 1.00
            end 
            describe "when price is not filled in" do
              it "should not add a new receipt item to the receipt" do
                # TODO: expect .. change wasn't working in this test?'
                expect(@receipt.receipt_items.length).to eq 0
                click_button 'modal-add-items'
                expect(@receipt.reload.receipt_items.length).to eq 0
                expect(page).to have_content("Price can't be blank")
                expect(page).to have_content("Price is not a number")
              end 
            end
            it "should add the item to the receipt table" do
              click_button 'modal-add-items'
              expect(page).to have_content(@receipt.reload.receipt_items.first.store_item.name)
            end

          end

          describe "when no items are checked" do
            it "should not add a receipt item to the receipt" do
              expect(@receipt.receipt_items.length).to eq 0
              click_button 'modal-add-items'                
              expect(@receipt.receipt_items.length).to eq 0
            end
          end
        end
      end
    end
  end
end
