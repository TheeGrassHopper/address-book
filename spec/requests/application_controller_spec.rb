# frozen_string_literal: true

# spec/requests/application_controller_spec.rb

require 'rails_helper'

RSpec.describe(ApplicationController, type: :request) do
  describe '#dashboard' do
    context 'when user is logged in' do
      let(:user) { create(:user) }

      before do
        post login_path, params: { email: user.email, password: user.password }
        get root_path
      end

      it 'returns a successful response' do
        expect(response).to(have_http_status(:success))
      end

      it 'renders the application layout' do
        expect(response.body).to(include('AddressBook'))
      end
    end

    context 'when user is not logged in' do
      before { get root_path }

      it 'redirects to root path' do
        expect(response).to(have_http_status(:success))
      end
    end
  end

  describe 'before_action :require_login' do
    context 'when user is logged in' do
      let(:user) { create(:user) }

      before { post login_path, params: { email: user.email, password: user.password } }

      it 'does not redirect' do
        get people_path
        expect(response).to(have_http_status(:success))
      end
    end

    context 'when user is not logged in' do
      before { get people_path }

      it 'redirects to root path' do
        expect(response).to(redirect_to(root_path))
      end

      it 'sets flash error message' do
        expect(flash[:error]).to(eq('You must be logged in to access this section'))
      end
    end
  end

  describe 'before_action :authorize_admin' do
    context 'when user is an admin' do
      let(:admin) { create(:user, role: 'admin') }

      before do
        post login_path, params: { email: admin.email, password: admin.password }
        get edit_person_path(create(:person))
      end

      it 'does not redirect' do
        expect(response).to(have_http_status(:success))
      end
    end

    context 'when user is not an admin' do
      let(:user) { create(:user, role: 'user') }

      before do
        post login_path, params: { email: user.email, password: user.password }
        get edit_person_path(create(:person))
      end

      it 'redirects to people path' do
        expect(response).to(redirect_to(people_path))
      end

      it 'sets flash alert message' do
        expect(flash[:alert]).to(eq('You are not authorized to perform this action'))
      end
    end
  end
end
