DEFAULT_PASSWORD = 'foobar'.freeze

class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :self_user, only: [:show]
  before_action :administrator, only: [:index, :new, :create]

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
      redirect_to edit_user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def self_user
    # @user = User.find(params[:id])
    # redirect_to(root_url) unless @user == current_user || current_user.admin?
    correct_user(params[:id])
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
