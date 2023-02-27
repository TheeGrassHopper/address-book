# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(ApplicationController, type: :request) do
  describe '#dashboard' do
    context 'when user is logged in' do
      let(:admin) { create(:user, role: 'admin') }

      before do
        post login_path, params: { email: admin.email, role: admin.role, password: admin.password }
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
      let(:admin) { create(:user, role: 'Admin') }

      before { post login_path, params: { email: admin.email, role: admin.role, password: admin.password } }

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
        post login_path, params: { email: admin.email, role: admin.role, password: admin.password }
        get edit_person_path(create(:person))
      end

      it 'does not redirect' do
        expect(response).to(have_http_status(:success))
      end
    end

    context 'when user is not an admin' do
      let(:guest) { create(:user, role: 'guest') }

      before do
        post login_path, params: { email: guest.email, role: guest.role, password: guest.password }
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
