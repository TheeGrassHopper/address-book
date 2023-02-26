# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :authorize_admin
  skip_before_action :set_current_user
  before_action :session_params, only: :create

  def new
    
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user&.authenticate(params[:password]) && user.role.casecmp(params[:role]).zero?
      session[:user_id] = user.id
      @current_user = user
    
      redirect_to(people_path)
    else
      flash.now[:alert] = 'email or password or role is invalid'
      render('new')
    end
  end

  def destroy
    reset_session
    session[:user_id] = nil
    redirect_to(login_path)
  end

  def session_params
    params.require(:password)
    params.require(:email)
    params.require(:role)
  rescue ActionController::ParameterMissing => e
    flash.now[:alert] = "Post creation failed: #{e.message}"
    render(:new)
  end
end
