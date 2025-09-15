class ProductsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = Product.all
    @categories = Product.distinct.pluck(:category).compact
    
    # 検索機能
    if params[:search].present?
      @products = @products.where("name ILIKE ? OR description ILIKE ?", 
                                 "%#{params[:search]}%", "%#{params[:search]}%")
    end
    
    # カテゴリフィルタ
    if params[:category].present?
      @products = @products.where(category: params[:category])
    end
    
    # 価格ソート
    case params[:sort]
    when 'price_asc'
      @products = @products.order(:price)
    when 'price_desc'
      @products = @products.order(price: :desc)
    when 'name_asc'
      @products = @products.order(:name)
    else
      @products = @products.order(created_at: :desc)
    end
    
    # ページネーション（将来の拡張用）
    @products = @products.limit(12)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.expect(product: [ :name, :description, :featured_image, :inventory_count, :price, :category ])
    end
end
