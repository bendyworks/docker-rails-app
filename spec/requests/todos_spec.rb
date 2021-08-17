require 'rails_helper'

RSpec.describe "Todos", type: :request do
  describe "GET /todos as a contrived example" do
    it "is successful" do
      get todos_path
      expect(response).to have_http_status(200)
    end
  end
end
