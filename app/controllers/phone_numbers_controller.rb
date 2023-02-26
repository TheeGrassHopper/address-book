# frozen_string_literal: true

class PhoneNumbersController < ApplicationController
  before_action :set_phone_number, only: %i[edit update destroy]

  def index
    @phone_numbers = PhoneNumber.all
  end

  def new
    @phone_number = PhoneNumber.new
  end

  def edit; end

  def create
    @phone_number = PhoneNumber.new(
      phone_number_params.merge(person_id: params[:person_id])
    )

    if @phone_number.save
      redirect_to(person_path(params[:person_id]), notice: 'Phone number was successfully created.')
    else
      render(json: @phone_number.errors, status: :unprocessable_entity)
    end
  end

  def update
    if @phone_number.update(phone_number_params)
      redirect_to(person_path(params[:person_id]), notice: 'Phone number was successfully updated.')
    else
      render(:edit, status: :unprocessable_entity, json: @phone_number.errors)
    end
  end

  def destroy
    redirect_to(person_path(params[:person_id]), notice: 'Phone number was successfully destroyed.') if @phone_number.destroy
  end

  private

  def set_phone_number
    @phone_number = Person.find(params[:person_id]).phone_numbers.where(id: params[:id]).take
  end

  def phone_number_params
    params.require(:phone_number).permit(:number, :comment, :person_id)
  end
end
