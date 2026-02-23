# frozen_string_literal: true

RSpec.describe "ApplicationController locale", type: :request do
  describe "locale handling" do
    it "sets locale from params" do
      get root_path(locale: :uk)

      expect(I18n.locale).to eq(:uk)
    end

    it "uses default locale if none provided" do
      get root_path

      expect(I18n.locale).to eq(I18n.default_locale)
    end

    it "includes locale in generated urls" do
      get root_path(locale: :en)

      expect(response.request.fullpath).to include("locale=en")
    end
  end
end
