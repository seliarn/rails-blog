class CategoriesController < ApplicationController
  # Controller responsible for managing categories.

  # GET /categories
  # Fetches a list of categories in descending order by ID.
  def index
    @categories = Category.order('id DESC').all
  end

  # GET /categories/:id
  # Displays the details of a specific category.
  def show
    @articles = Category.find(params[:id]).articles
  end

  # GET /categories/new
  # Initializes a new category object for creating a new category.
  def new
    @category = Category.new
  end

  # POST /categories
  # Creates a new category with the provided parameters.
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /categories/:id/edit
  # Displays the form to edit an existing category.
  def edit
    @category = Category.find(params[:id])
  end

  # PATCH/PUT /categories/:id
  # Updates an existing category with the provided parameters.
  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to categories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /categories/:id
  # Deletes an existing category.
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to root_path, status: :see_other
  end

  private

  # Strong parameters for category creation and update.
  def category_params
    params.require(:category).permit(:title, :description)
  end
end
