DEFAULT_PASSWORD = 'inicio'

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.active = true
    @user.password = DEFAULT_PASSWORD
    @user.password_confirmation = DEFAULT_PASSWORD
    if @user.save
      flash[:success] = 'User was succesfully saved'
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name,
                                 :name,
                                 :last_name,
                                 :email,
                                 :admin,
                                 :active,
                                 :password_expires,
                                 :password,
                                 :password_confirmation)
  end
end
