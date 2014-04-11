class StoreItemsController < ApplicationController
  before_action :signed_in_user, only: [:create, :new]

  # POST /store_items/
  def create
    @store_item = StoreItem.new(store_item_params)
    if @store_item.save
      flash[:success] = "New store item created!"
      redirect_to root_url
    else
      @errors = @store_item.errors
      render 'new'
    end    
  end

  # GET /store_items/
  def new
  end

  private
  def store_item_params
    params.require(:store_item).permit(:description, :upc, :price, :weight, :volume, :name, :category_id, :store_id)
  end

  # Before filters
  def signed_in_user
    unless signed_in?
      flash[:errors] = "Please sign in."
      redirect_to root_url
    end
  end
  
end
