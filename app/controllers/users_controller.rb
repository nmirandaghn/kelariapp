DEFAULT_PASSWORD = 'inicio'.freeze

class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :administrator, except: [:change_password, :update_password]
  # before_action :correct_user, only: [:change_password, :update_password]

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def reset
    @user = User.find(params[:user_id])
    @user.password = DEFAULT_PASSWORD
    @user.password_confirmation = DEFAULT_PASSWORD

    flash[:success] = @user.save ? 'Password reseted' : 'Error'
    redirect_to edit_user_path(@user)
  end

  # def change_password; end

  # def change_password
  #   if user_params[:password] != user_params[:password_confirmation]
  #     flash[:success] = 'Passwords are not equal'
  #     render 'change_password'
  #   end
  #   @user.password = user_params[:password]
  #   @user.password_confirmation = user_params[:password_confirmation]
  #   if @user.save
  #     flash[:success] = 'Password was succesfully changed'
  #     redirect_to root_url
  #   end
  #   render 'change_password'
  # end

  private

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless @user == current_user
  end

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

#https://www.sitepoint.com/handle-password-and-email-changes-in-your-rails-api/
