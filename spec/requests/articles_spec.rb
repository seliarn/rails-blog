require 'rails_helper'

RSpec.describe "Articles", type: :request do
  current_user = User.first_or_create(
    id: 1,
    email: 'testreq@example.com',
    password: '123456'
  )

  article = Article.first_or_create(
    id: 1,
    title: "Test title",
    author: current_user,
    user_id: current_user.id
  )

  describe "GET /" do
    it "index page opened" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /articles/:id" do
    it "get a successful show page by id" do
      get articles_path(article)

      expect(response).to be_successful
    end
  end

  describe "GET /post/:slug" do
    it "get a successful show page by slug" do
      get post_path(slug: article.url)

      expect(response).to be_successful
    end

    it "get a 404 page by wrong slug" do
      expect {
        get post_path(slug: 'wrong-page-url')
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'Guest redirects' do
    it 'redirect from new article page to sign in for guests' do
      get new_article_path
      expect(response).to have_http_status(302)
    end

    it 'redirect from edit article page to sign in for guests' do
      get edit_article_path(article)
      expect(response).to have_http_status(302)
    end

    it 'ignore POST request and redirect to sign_in for guests' do
      post articles_path, params: {
        title: article.title + '_created'
      }

      expect(response).to have_http_status(302)
    end

    it 'ignore PATCH request and redirect to sign_in for guests' do
      patch article_path(article), params: {
        title: article.title + '_patched'
      }

      expect(response).to have_http_status(302) #
    end
  end

  describe 'GET /new' do
    it 'get a successful creating article page' do
      sign_in current_user
      get new_article_path
      expect(response).to be_successful
    end
  end

  describe 'GET /articles/:id/edit' do
    it 'render a successful response' do
      sign_in current_user
      get edit_article_path(article)
      expect(response).to be_successful
    end
  end

  describe 'POST /articles' do
    it 'creates a new Article' do
      sign_in current_user

      expect do
        post articles_path, params: {
          article: {
            title: 'created article',
            user_id: current_user.id
          }
        }
      end.to change(Article, :count).by(1)
    end
  end

  describe 'PATCH /articles/:id' do
    it 'creates a new Article' do
      sign_in current_user

      old_article = Article.first
      old_title = old_article.title
      patch article_path(old_article), params: {
        article: {
          title: 'new patched article title',
          user_id: current_user.id
        }
      }
      old_article.reload

      expect(old_article.title).to_not eq(old_title)
    end
  end
end
