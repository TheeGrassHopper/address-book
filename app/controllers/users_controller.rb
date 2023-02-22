# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :authorize_admin, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.password ==  user_params[:password_confirmation] && @user.save
      session[:user_id] = @user.id
      @current_user = @user

      redirect_to(people_path, notice: 'User was successfully created.')
    else
      render(:new)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end
