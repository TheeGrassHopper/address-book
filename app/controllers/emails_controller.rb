# frozen_string_literal: true

class EmailsController < ApplicationController
  before_action :set_email, only: %i[edit update destroy]

  def index
    @emails = Email.all
  end

  def new
    @email = Email.new
  end

  def edit; end

  def create
    @email = Email.new(email_params.merge(person_id: params[:person_id]))
    if @email.save
      redirect_to(person_path(@email.person), notice: 'Email was successfully created.')
    else
      render(json: @email.errors, status: :unprocessable_entity)
    end
  end

  def update
    if @email.update(email_params)
      redirect_to(person_path(params[:person_id]), notice: 'Email was successfully updated.')
    else
      render(json: @email.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    @email.destroy!

    respond_to do |format|
      format.html { redirect_to(person_path(params[:person_id]), notice: 'Email was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  def set_email
    @email ||= Person.find(params[:person_id]).emails.where(id: params[:id]).take
  end

  def email_params
    params.require(:emails).permit(:email, :comment, :person_id)
  end
end
