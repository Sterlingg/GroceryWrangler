class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      sign_in @user
      redirect_to receipts_path
    else
      flash.now[:error] = 'Invalid email/password combination'
    end
  end

  def destroy
  end
end
