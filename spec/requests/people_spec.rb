require 'rails_helper'


RSpec.describe PeopleController, type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:person) }
  let(:invalid_attributes) { attributes_for(:person, ssn: nil) }
  let(:valid_params) { { person: valid_attributes } }
  let(:invalid_params) { { person: invalid_attributes } }

  before do
    post login_path, params: { email: user.email, password: user.password, role: user.role } 
  end

  describe "GET /people" do
    it "renders a successful response" do
      get people_path
      expect(response).to be_successful
    end

    it "renders JSON" do
      get people_path(format: :json)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "GET /people/:id" do
    let(:person) { create(:person) }

    it "renders a successful response" do
      get person_path(person)
      expect(response).to be_successful
    end
  end

  describe "GET /people/new" do
    it "renders a successful response" do
      get new_person_path
      expect(response).to be_successful
    end
  end

  describe "GET /people/:id/edit" do
    let(:person) { create(:person) }

    it "renders a successful response" do
      get edit_person_path(person)
      expect(response).to be_successful
    end
  end

  describe "POST /people" do
    context "with valid parameters" do
      it "creates a new Person" do
        expect {
          post people_path, params: valid_params
        }.to change(Person, :count).by(1)
      end

      it "redirects to the people index" do
        post people_path, params: valid_params
        expect(response).to redirect_to(people_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Person" do
        expect {
          post people_path, params: invalid_params
        }.to_not change(Person, :count)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post people_path, params: invalid_params
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /people/:id" do
    let(:person) { create(:person) }

    context "with valid parameters" do
      let(:new_attributes) { attributes_for(:person) }

      it "updates the requested person" do
        patch person_path(person), params: { person: new_attributes }
        person.reload
        expect(person.ssn).to eq(new_attributes[:ssn])
      end

      it "redirects to the people index" do
        patch person_path(person), params: { person: new_attributes }
        expect(response).to redirect_to(people_path)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch person_path(person), params: invalid_params
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /people/:id" do
    let!(:person) { create(:person) }

    it "destroys the requested person" do
      expect {
        delete person_path(person)
      }.to change(Person, :count).by(-1)
    end
  end
end
