class ReceiptsController < ApplicationController

  # def edit
  #   @user = User.find(params[:id])
  # end

  def index
    @receipts = Receipt.all()
  end

  def show
    @receipt = Receipt.find(params[:id])
  end

end
