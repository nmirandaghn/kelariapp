class PasswordChangesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if user_params[:password] != user_params[:password_confirmation]
      flash[:danger] = 'Passwords are not equal'
      render 'edit'
    end
    @user.password = user_params[:password]
    @user.password_confirmation = user_params[:password_confirmation]
    if @user.save
      flash[:success] = 'Password was succesfully changed'
      redirect_to root_url
    end
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:password,
                                 :password_confirmation)
  end
end
