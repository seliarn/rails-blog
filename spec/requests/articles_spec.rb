require 'rails_helper'

RSpec.describe "Articles", type: :request do

  article = Article.create(
    title: "Test title",
  )

  describe "GET /" do
    it "index page opened" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
