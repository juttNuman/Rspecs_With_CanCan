class ProductsController < ApplicationController
  include ActionController::MimeResponds
  before_action :set_product, only: %i[ show update destroy ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /products
  def index
    @products = Product.all

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
   if user_signed_in?
     @product = Product.new(product_params)
     if @product.save
       render json: @product, status: :created, location: @product
     elsif can?(:create, @product)
       render json: { error: "Unprocessable Entity", message: @product.errors.full_messages }, status: :unprocessable_entity
     else
       render json: { error: "Access denied" }, status: :forbidden
     end
    else
      render json: {error: "please login first"}, status: :unauthorized
    end
  end
  
  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :price)
    end
end
