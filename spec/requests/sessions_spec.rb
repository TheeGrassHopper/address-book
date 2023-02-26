# frozen_string_literal: true

require 'rails_helper'
require_relative '../helper/session_helper_spec'

RSpec.describe(SessionsController, type: :request) do
  describe 'GET #new' do
    it 'renders the new template' do
      get login_path

      expect(response).to(render_template(:new))
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      let(:user) { create(:user) }

      it 'logs in the user and redirects to people_path' do
        post login_path, params: { email: user.email, password: user.password, role: user.role }
        expect(session[:user_id]).to(eq(user.id))
        expect(response).to(redirect_to(people_path))
      end
    end

    context 'with invalid credentials' do
      it 'renders the new template with an error message' do
        post login_path, params: { email: 'invalid', password: 'invalid', role: 'invalid' }
        expect(flash[:alert]).to(match(/email or password or role is invalid/))
        expect(response).to(render_template(:new))
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }

    before do
      login_user(user)
    end

    it 'logs out the user and redirects to login_path' do
      delete logout_path
      expect(session[:user_id]).to(be_nil)
      expect(response).to(redirect_to(login_path))
    end
  end
end
