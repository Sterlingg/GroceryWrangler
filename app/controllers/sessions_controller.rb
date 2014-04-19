class SessionsController < ApplicationController
  before_action :signed_in_user, only: [:destroy]
  
  # POST /sessions
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      sign_in @user
      redirect_to receipts_path
    else
      flash.now[:errors] = 'Invalid email/password combination'
    end
  end

  # DELETE /session/#
  def destroy
    sign_out
    redirect_to root_url
  end

  # Before filters
  def signed_in_user
    unless signed_in?
      flash[:errors] = "Please sign in."
      redirect_to root_url
    end
  end
end
