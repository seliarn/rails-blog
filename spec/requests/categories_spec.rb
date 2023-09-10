require 'rails_helper'

RSpec.describe "Categories", type: :request do

  let(:current_user) { create(:user) }
  let(:category) { create(:category) }

  describe "GET /categories" do
    it "Categories list page" do
      get categories_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /categories/:id" do
    it "Get a successful category show page by id" do
      get category_path(category)

      expect(response).to be_successful
    end
  end

  describe 'Guest redirects' do
    it 'Redirect from new category page to sign in for guests' do
      get new_category_path
      expect(response).to have_http_status(302)
    end

    it 'Redirect from edit category page to sign in for guests' do
      get edit_category_path(category)
      expect(response).to have_http_status(302)
    end

    it 'Ignore POST request and redirect to sign_in for guests' do
      post categories_path, params: {
        title: category.title + '_created'
      }

      expect(response).to have_http_status(302)
    end

    it 'Ignore PATCH request and redirect to sign_in for guests' do
      patch category_path(category), params: {
        title: category.title + '_patched'
      }

      expect(response).to have_http_status(302) #
    end
  end

  describe 'GET /new' do
    it 'Get a successful creating category page' do
      sign_in current_user
      get new_category_path
      expect(response).to be_successful
    end
  end

  describe 'GET /category/:id/edit' do
    it 'Render a successful response' do
      sign_in current_user
      get edit_category_path(category)
      expect(response).to be_successful
    end
  end

  describe 'POST /categories' do
    it 'Create a new category' do
      sign_in current_user

      expect do
        post categories_path, params: {
          category: {
            title: 'created category'
          }
        }
      end.to change(Category, :count).by(1)
    end
  end

  describe 'PATCH /categories/:id' do
    let(:new_title) { 'new patched category title' }
    it 'Update category' do
      sign_in current_user

      expect do
        patch category_path(category), params: {
          category: {
            title: new_title,
          }
        }
      end.to change(Category, :count).by(0).and change { category.reload.title }.to(new_title)
    end
  end
end
