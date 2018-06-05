class PasswordResetsController < ApplicationController
  def edit
  end

  def update
    @user = User.find(params[:id])
    @user.password = DEFAULT_PASSWORD
    @user.password_confirmation = DEFAULT_PASSWORD

    flash[:success] = @user.save ? 'Password reseted' : 'Error'
    redirect_to edit_user_path(@user)
  end
end