class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
  end

  def selection_dialog
    @categories = Category.all()
    @receipt = Receipt.find(params[:receipt])
    respond_to do |format|
      format.js 
    end
  end
end
