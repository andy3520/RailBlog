class UsersController < ApplicationController
  before_action :find_user, only: [:show, :avatar, :cover]
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

  def save_avatar
    if current_user.update(avatar_param)
      respond_to do |f|
        f.js {}
      end
    end
  end

  def cover
    respond_to do |f|
      f.js {}
    end
  end

  def save_cover
    if current_user.update(cover_param)
      respond_to do |f|
        f.js {}
      end
    end
  end

  private

  def avatar_param
    params.require(:user).permit(:avatar)
  end

  def cover_param
    params.require(:user).permit(:cover)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
