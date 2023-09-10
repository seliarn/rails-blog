class ArticlesController < ApplicationController
  # Controller responsible for managing articles.
  before_action :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource

  # GET /articles
  # Fetches a list of articles in descending order by ID.
  def index
    @articles = Article.all
  end

  # GET /articles/:id
  # GET /post/:slug
  # Displays the details of a specific article.
  # If a slug is provided, searches for the article by URL slug; otherwise, searches by ID.
  def show
    @article = params[:slug] ? Article.find_by!(url: params[:slug]) : Article.find(params[:id])
  end

  # GET /articles/new
  # Initializes a new article object for creating a new article.
  def new
    @article = Article.new(:categories => Category.all)
  end

  # POST /articles
  # Creates a new article with the provided parameters.
  def create
    if helpers.upload_image_if_exists(params[:article][:file])
      params[:article][:preview_picture] = params[:article][:file].original_filename
    end

    # HERE WAS SECURITY ISSUE
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /articles/:id/edit
  # Displays the form to edit an existing article.
  def edit
    @article = Article.find(params[:id])
  end

  # PATCH/PUT /articles/:id
  # Updates an existing article with the provided parameters.
  def update
    #
    @article = current_user.articles.find(params[:id])

    if !params[:article][:file].nil? && helpers.upload_image_if_exists(params[:article][:file])
      params[:article][:preview_picture] = params[:article][:file].original_filename
    end

    if @article.update(article_params)
      redirect_to post_path(slug: @article.url)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  # Deletes an existing article.
  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  # Strong parameters for article creation and update.
  def article_params
    params.require(:article).permit(:url, :title, :preview_picture, :body, :short_body, :publish_date, category_ids: [])
  end
end
