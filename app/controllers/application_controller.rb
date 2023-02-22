# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user
  before_action :require_login, except: [:dashboard]
  before_action :authorize_admin, only: %i[create edit update destroy]

  def dashboard
    render('layouts/application')
  end

  private

  def require_login
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
    unless User.find_by(id: session[:user_id]) && session[:user_id]
      flash[:error] = 'You must be logged in to access this section'
      redirect_to(root_path)
    end
  end

  def authorize_admin
    unless current_user.role.casecmp('admin').zero?
      redirect_to(people_path)
      flash[:alert] = 'You are not authorized to perform this action'
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
