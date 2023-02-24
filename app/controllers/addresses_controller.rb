# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :set_address, only: %i[show edit update destroy]

  def index
    @addresses ||= Person.find(params[:person_id]).addresses
  end

  def show; end

  def new
    @address = Address.new
  end

  def edit; end

  def create
    @address = Address.new(address_params.merge(person_id: params[:person_id]))
    if @address.save
      redirect_to(person_path(@address.person))
    else
      render(json: @address.errors, status: :unprocessable_entity)
    end
  end

  def update
    if @address.update(address_params)
      redirect_to(person_path(params[:person_id]), notice: 'Address was successfully updated.')
    else
      render(:edit, json: @address.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    @address.destroy!
    respond_to do |format|
      format.html { redirect_to(person_path(params[:person_id]), notice: 'Address was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  def set_address
    @address ||= Person.find(params[:person_id]).addresses.where(id: params[:id]).take
  end

  def address_params
    params.require(:address).permit(:street, :town, :zip_code, :state, :country, :person_id)
  end
end

# Path: app/controllers/phone_numbers_controller.rb
# frozen_string_literal: true

class PhoneNumbersController < ApplicationController
  before_action :set_phone_number, only: %i[show edit update destroy]

  def index
    @phone_numbers ||= Person.find(params[:person_id]).phone_numbers
  end

  def show; end

  def new
    @phone_number = PhoneNumber.new
  end

  def edit; end

  def create
    @phone_number = PhoneNumber.new(phone_number_params.merge(person_id: params[:person_id]))
    if @phone_number.save
      redirect_to(person_path(@phone_number.person), notice: 'Phone number was successfully created.')
    else
      render(json: @phone_number.errors, status: :unprocessable_entity)
    end
  end

  def update
    if @phone_number.update(phone_number_params)
      redirect_to(person_path(params[:person_id]), notice: 'Phone number was successfully updated.')
    else
      render(:edit, json: @phone_number.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    @phone_number.destroy!
    respond_to do |format|
      format.html { redirect_to(person_path(params[:person_id]), notice: 'Phone number was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  def set_phone_number
    @phone_number ||= Person.find(params[:person_id]).phone_numbers.where(id: params[:id]).take
  end

  def phone_number_params
    params.require(:phone_number).permit(:number, :comment, :person_id)
  end
end
