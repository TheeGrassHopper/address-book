# frozen_string_literal: true

class PeopleController < ApplicationController
  before_action :set_person, only: %i[show edit update destroy]

  def index
    @people = Person.all

    respond_to do |format|
      format.html
      format.json { render(:index) }
    end
  end

  def show; end

  def new
    @person = Person.new
  end

  def edit; end

  def create
    update_person_params = person_params.merge(user_id: @current_user.id) unless session[:user_id].nil?
    @person = Person.new(update_person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to(people_url, notice: 'Person was successfully created.') }
        format.json { render(:show, status: :created, location: @person) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @person.errors, status: :unprocessable_entity) }
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to(people_url, notice: 'Person was successfully updated.') }
        format.json { render(:show, status: :ok, location: @person) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @person.errors, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @person.destroy!

    respond_to do |format|
      format.html { redirect_to(people_url, notice: 'Person was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:id, :salutation, :first_name, :middle_name, :last_name, :ssn, :birth_date, :comment, emails_attributes: %i[id email comment], phone_numbers_attributes: %i[id number comment], addresses_attributes: %i[id street town zip_code state country]
    )
  end
end
