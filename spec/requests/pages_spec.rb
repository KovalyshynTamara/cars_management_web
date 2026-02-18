# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /help" do
    it "returns http success" do
      get help_path
      expect(response).to have_http_status(:ok)
    end
  end
end
