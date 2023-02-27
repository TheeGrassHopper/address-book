# frozen_string_literal: true

require 'rails_helper'
require_relative '../helper/session_helper_spec'

RSpec.describe(PhoneNumbersController, type: :request) do
  let(:user) { FactoryBot.create(:user) }
  let(:person) { FactoryBot.create(:person) }
  let(:valid_attributes) { FactoryBot.attributes_for(:phone_number) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:phone_number, number: nil) }

  before { login_user(user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get person_phone_numbers_path(person)
      expect(response).to(be_successful)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_person_phone_number_path(person)
      expect(response).to(be_successful)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      phone_number = FactoryBot.create(:phone_number, person: person)
      get edit_person_phone_number_path(person, phone_number)
      expect(response).to(be_successful)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new PhoneNumber and redirects to the created person' do
        expect do
          post(person_phone_numbers_path(person), params: { phone_number: valid_attributes })
        end.to(change(PhoneNumber, :count).by(1))

        expect(response).to(redirect_to(person_path(person)))
      end
    end

    context 'with invalid params' do
      it 'does not create a new PhoneNumber' do
        expect do
          post(person_phone_numbers_path(person), params: { phone_number: invalid_attributes })
        end.to(change(PhoneNumber, :count).by(0))
      end

      it 'renders a JSON response with errors for the new phone_number' do
        post person_phone_numbers_path(person), params: { phone_number: invalid_attributes }
        expect(response.content_type).to(eq('application/json; charset=utf-8'))
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) { { number: '555-1234' } }

      it 'updates the requested phone_number and redirects to the person' do
        phone_number = FactoryBot.create(:phone_number, person: person)
        patch person_phone_number_path(person, phone_number), params: { phone_number: new_attributes }
        phone_number.reload
        expect(phone_number.number).to(eq('555-1234'))
        expect(response).to(redirect_to(person_path(person)))
      end
    end

    context 'with invalid params' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        phone_number = FactoryBot.create(:phone_number, person: person)
        patch person_phone_number_path(person, phone_number), params: { phone_number: invalid_attributes }

        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:phone_number) { FactoryBot.create(:phone_number, person: person) }

    it 'destroys the phone_number and redirects to the person' do
      expect do
        delete(person_phone_number_path(person, phone_number))
      end.to(change(PhoneNumber, :count).by(-1))

      expect(response).to(redirect_to(person_path(person)))
    end
  end
end
