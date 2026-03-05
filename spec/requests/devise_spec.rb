# frozen_string_literal: true

RSpec.describe "User registration", type: :request do
  describe "POST /users" do
    it "allows full_name parameter" do
      expect {
        post user_registration_path, params: {
          user: {
            email: "test@example.com",
            password: "password123",
            password_confirmation: "password123",
            full_name: "Test User"
          }
        }
      }.to change(User, :count).by(1)

      expect(User.last.full_name).to eq("Test User")
    end
  end
end
