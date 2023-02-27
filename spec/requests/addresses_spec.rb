# frozen_string_literal: true

require 'rails_helper'
require_relative '../helper/session_helper_spec'

RSpec.describe(AddressesController, type: :request) do
  let(:user) { FactoryBot.create(:user, role: 'admin') }
  let(:person) { FactoryBot.create(:person) }
  let(:valid_attributes) { FactoryBot.attributes_for(:address) }
  let(:invalid_attributes) { valid_attributes.merge(street: nil) }

  before { login_user(user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get person_addresses_path(person)

      expect(response).to(have_http_status(:ok))
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      address = FactoryBot.create(:address, person: person)
      get person_address_path(person, address)
      expect(response).to(have_http_status(:ok))
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_person_address_path(person)
      expect(response).to(have_http_status(:ok))
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      address = FactoryBot.create(:address, person: person)
      get edit_person_address_path(person, address)
      expect(response).to(be_successful)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Address and redirects to the created address' do
        expect do
          post(person_addresses_path(person), params: { address: valid_attributes })
        end.to(change(Address, :count).by(1))
        expect(response).to(redirect_to(person_path(person)))
      end
    end

    context 'with invalid params' do
      it 'does not create a new Address and returns a 422 status code' do
        expect do
          post(person_addresses_path(person), params: { address: invalid_attributes })
        end.to_not(change(Address, :count))
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end

    context 'when the user is non admin' do
      let(:user) { FactoryBot.create(:user, role: 'guest') }
      let!(:addresse) { FactoryBot.create(:address, person: person) }

      it 'redirects to the person page and flashs error message' do
        post(person_addresses_path(person, addresse), params: { address: valid_attributes })

        expect(response).to(redirect_to(people_path))
        expect(flash[:alert]).to(eq('You are not authorized to perform this action'))
      end
    end
  end

  describe 'PATCH #update' do
    let(:new_attributes) { { street: 'New Street' } }

    context 'with valid params' do
      it 'updates the requested address and redirects to the person' do
        address = FactoryBot.create(:address, person: person)
        patch person_address_path(person, address), params: { address: new_attributes }
        address.reload
        expect(address.street).to(eq(new_attributes[:street]))
        expect(response).to(redirect_to(person_path(person)))
      end
    end

    context 'with invalid params' do
      it 'returns a 422 status code' do
        address = FactoryBot.create(:address, person: person)
        patch person_address_path(person, address), params: { address: invalid_attributes }
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested address and redirects to the person' do
      address = FactoryBot.create(:address, person: person)

      expect do
        delete(person_address_path(person, address))
      end.to(change { Address.count }.by(-1))
      expect(response).to(redirect_to(person_path(person)))
    end
  end

  { update: 'PATCH', edit: 'PUT', destroy: 'DELETE' }.each do |action, verb|
    let(:address) { FactoryBot.create(:address, person: person) }

    describe "#{verb} #{action}" do
      let(:user) { FactoryBot.create(:user, role: 'guest') }

      context 'when the user is non admin' do
        it 'redirects to the person page and flashs error message' do
          send(verb.downcase, person_address_path(person, address))
          expect(response).to(redirect_to(people_path))
          expect(flash[:alert]).to(eq('You are not authorized to perform this action'))
        end
      end
    end
  end
end
