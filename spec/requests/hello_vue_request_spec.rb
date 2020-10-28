require 'rails_helper'

RSpec.describe "HelloVues", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/hello_vue/index"
      expect(response).to have_http_status(:success)
    end
  end

end
