# frozen_string_literal: true

require 'rails_helper'
require_relative '../helper/session_helper_spec'

RSpec.describe(EmailsController, type: :request) do
  let(:user) { FactoryBot.create(:user, role: 'Admin') }
  let(:person) { FactoryBot.create(:person) }

  before { login_user(user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get person_emails_path(person)
      expect(response).to(be_successful)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_person_email_path(person)
      expect(response).to(be_successful)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      email = FactoryBot.create(:email, person: person)
      get edit_person_email_path(person, email)
      expect(response).to(be_successful)
    end
  end

  describe 'POST #create' do
    context 'with valid email address' do
      it 'creates a new email and redirects to the person' do
        expect do
          post(person_emails_path(person), params: { emails: { email: 'test@example.com', person_id: person.id } })
        end.to(change(Email, :count).by(1))

        expect(response).to(redirect_to(person_path(person)))
      end
    end

    context 'with invalid email address' do
      it 'returns a JSON error response' do
        post person_emails_path(person), params: { emails: { email: 'test#examplecom', person_id: person.id } }

        expect(response).to(have_http_status(:unprocessable_entity))
        expect(JSON.parse(response.body)).to(include('email' => ['is not a valid email address']))
      end
    end

    context 'when the user is non admin' do
      let(:user) { FactoryBot.create(:user, role: 'guest') }
      let!(:email) { FactoryBot.create(:email, person: person) }

      it 'redirects to the person and flash error message' do
        post(person_emails_path(person, email), params: { emails: { email: 'email@email.com' } })

        expect(response).to(redirect_to(people_path))
        expect(flash[:alert]).to(eq('You are not authorized to perform this action'))
      end
    end
  end

  describe 'PATCH #update' do
    let!(:email) { FactoryBot.create(:email, person: person) }

    context 'with vaild email address' do
      it 'updates the email and redirects to the person' do
        patch person_email_path(person, email), params: { emails: { email: 'new_email@example.com' } }

        expect(email.reload.email).to(eq('new_email@example.com'))
        expect(response).to(redirect_to(person_path(person)))
      end
    end

    context 'with invalid email address' do
      it 'returns a JSON error response' do
        patch person_email_path(person, email), params: { emails: { email: 'new_email@examplem' } }

        expect(response).to(have_http_status(:unprocessable_entity))
        expect(JSON.parse(response.body)).to(include('email' => ['is not a valid email address']))
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:email) { FactoryBot.create(:email, person: person) }

    it 'destroys the email and redirects to the person' do
      expect do
        delete(person_email_path(person, email))
      end.to(change(Email, :count).by(-1))

      expect(response).to(redirect_to(person_path(person)))
    end
  end

  { update: 'PATCH', edit: 'PUT', destroy: 'DELETE' }.each do |action, verb|
    let(:email) { FactoryBot.create(:email, person: person) }

    describe "#{verb} #{action}" do
      let(:user) { FactoryBot.create(:user, role: 'guest') }

      context 'when the user is non admin' do
        it 'redirects to the people page and flashs error message' do
          send(verb.downcase, person_phone_number_path(person, email))
          expect(response).to(redirect_to(people_path))
          expect(flash[:alert]).to(eq('You are not authorized to perform this action'))
        end
      end
    end
  end
end
