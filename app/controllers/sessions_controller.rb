class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to posts_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      flash.discard[:danger]
      render "blog/index"
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
