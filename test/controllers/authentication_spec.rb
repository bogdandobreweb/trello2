require 'rails_helper'

RSpec.describe "Authentication", type: :request do
    describe "GET /boards" do
      context "when user is not logged in" do
        it "redirects to sign in page" do
            gets '/boards'
            expect(response).to redirect_to(new_user_session_path)
        end
      end
  
      context "when user is logged in" do
        let(:user) { User.create(name: "John", email: "john@example.com", password: "password") }
      
        it "returns status code 200" do
          sign_in user
          get "/boards"
          expect(response).to have_http_status(200)
        end
      end
    end
end