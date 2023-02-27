# frozen_string_literal: true

require 'rails_helper'
require_relative '../helper/session_helper_spec'

RSpec.describe(PeopleController, type: :request) do
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:person) }
  let(:invalid_attributes) { attributes_for(:person, ssn: '12345678910') }
  let(:valid_params) { { person: valid_attributes } }
  let(:invalid_params) { { person: invalid_attributes } }

  before { login_user(user) }

  describe 'GET #index' do
    it 'renders a successful response' do
      get people_path
      expect(response).to(be_successful)
    end

    it 'renders JSON' do
      get people_path(format: :json)
      expect(response.content_type).to(eq('application/json; charset=utf-8'))
    end
  end

  describe 'GET #show' do
    let(:person) { create(:person) }

    it 'renders a successful response' do
      get person_path(person)
      expect(response).to(be_successful)
    end
  end

  describe 'GET #new' do
    it 'renders a successful response' do
      get new_person_path
      expect(response).to(be_successful)
    end
  end

  describe 'GET #edit' do
    let(:person) { create(:person) }

    it 'renders a successful response' do
      get edit_person_path(person)
      expect(response).to(be_successful)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Person' do
        expect do
          post(people_path, params: valid_params)
        end.to(change(Person, :count).by(1))
      end

      it 'redirects to the people index' do
        post people_path, params: valid_params
        expect(response).to(redirect_to(people_path))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Person' do
        expect do
          post(people_path, params: invalid_params)
        end.to_not(change(Person, :count))
      end
    end

    context 'when the user is non admin' do
      let(:user) { FactoryBot.create(:user, role: 'guest') }
      let!(:person) { FactoryBot.create(:person) }

      it 'redirects to the people page and flashs error message' do
        post(people_path(person), params: valid_params)

        expect(response).to(redirect_to(people_path))
        expect(flash[:alert]).to(eq('You are not authorized to perform this action'))
      end
    end
  end

  describe 'PATCH #update' do
    let(:person) { create(:person) }

    context 'with valid parameters' do
      let(:new_attributes) { attributes_for(:person) }

      it 'updates the requested person' do
        patch person_path(person), params: { person: new_attributes }
        person.reload
        expect(person.ssn).to(eq(new_attributes[:ssn].to_s))
      end

      it 'redirects to the people index' do
        patch person_path(person), params: { person: new_attributes }
        expect(response).to(redirect_to(people_path))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch person_path(person), params: invalid_params
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:person) { create(:person) }

    it 'destroys the requested person' do
      expect do
        delete(person_path(person))
      end.to(change(Person, :count).by(-1))
    end
  end

  { update: 'PATCH', edit: 'PUT', destroy: 'DELETE' }.each do |action, verb|
    describe "#{verb} #{action}" do
      let(:user) { FactoryBot.create(:user, role: 'guest') }
      let(:person) { FactoryBot.create(:person) }

      context 'when the user is non admin' do
        it 'redirects to the people page and flashs error message' do
          send(verb.downcase, person_path(person))
          expect(response).to(redirect_to(people_path))
          expect(flash[:alert]).to(eq('You are not authorized to perform this action'))
        end
      end
    end
  end
end
