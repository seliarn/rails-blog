require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let(:current_user) { create(:user) }
  let(:article) { create(:article, author: current_user) }

  describe "GET /" do
    it "Index page opened" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /articles/:id" do
    it "Get a successful show page by id" do
      get articles_path(article)

      expect(response).to be_successful
    end
  end

  describe "GET /post/:slug" do
    it "Get a successful show page by slug" do
      get post_path(slug: article.url)

      expect(response).to be_successful
    end

    it "Get a 404 page by wrong slug" do
      expect {
        get post_path(slug: 'wrong-page-url')
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'Guest redirects' do
    it 'Redirect from new article page to sign in for guests' do
      get new_article_path
      expect(response).to have_http_status(302)
    end

    it 'Redirect from edit article page to sign in for guests' do
      get edit_article_path(article)
      expect(response).to have_http_status(302)
    end

    it 'Ignore POST request and redirect to sign_in for guests' do
      post articles_path, params: {
        title: article.title + '_created'
      }

      expect(response).to have_http_status(302)
    end

    it 'Ignore PATCH request and redirect to sign_in for guests' do
      patch article_path(article), params: {
        title: article.title + '_patched'
      }

      expect(response).to have_http_status(302) #
    end
  end

  describe 'GET /new' do
    it 'Get a successful creating article page' do
      sign_in current_user
      get new_article_path
      expect(response).to be_successful
    end
  end

  describe 'GET /articles/:id/edit' do
    it 'Render a successful response' do
      sign_in current_user
      get edit_article_path(article)
      expect(response).to be_successful
    end
  end

  describe 'POST /articles' do
    it 'Create a new Article' do
      sign_in current_user

      expect do
        post articles_path, params: {
          article: {
            title: 'created article',
            # user_id: current_user.id # WARN: user_id is not permitted, this is security issue
          }
        }
      end.to change(Article, :count).by(1)
    end
  end

  describe 'PATCH /articles/:id' do
    let(:new_title) { 'new patched article title' }
    it 'Update Article' do
      sign_in current_user

      expect do
        patch article_path(article), params: {
          article: {
            title: new_title,
              # user_id: current_user.id # WARN: user_id is not permitted, this is security issue
          }
        }
      end.to change(Article, :count).by(0).and change{ article.reload.title }.to(new_title)
    end
  end
end
