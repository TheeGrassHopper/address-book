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
