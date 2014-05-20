class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Successfully logged in."
      redirect_to root_url
    else
      @errors = @user.errors
      render 'new'
    end    
  end

  def index
  end

  def new
    @user = User.new
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
