class UsersController < ApplicationController
  before_action :find_user, only: [:show,:edit]
  def new
    @user = User.new
  end

  def show

  end

  def edit

  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to Viblog!'
      redirect_to @user
    else
      render 'users/new'
    end
  end

  def avatar

      respond_to do |f|
        f.js {}
      end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
