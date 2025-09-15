class CartsController < ApplicationController
  allow_unauthenticated_access only: [:show, :add_item, :remove_item, :update_quantity]
  before_action :set_cart

  def show
  end

  def add_item
    product = Product.find(params[:product_id])
    quantity = params[:quantity]&.to_i || 1
    
    @cart.add_product(product, quantity)
    
    redirect_to cart_path, notice: "#{product.name} をカートに追加しました。"
  end

  def remove_item
    cart_item = @cart.cart_items.find(params[:cart_item_id])
    cart_item.destroy
    
    redirect_to cart_path, notice: "商品をカートから削除しました。"
  end

  def update_quantity
    cart_item = @cart.cart_items.find(params[:cart_item_id])
    quantity = params[:quantity].to_i
    
    if quantity > 0
      cart_item.update(quantity: quantity)
      redirect_to cart_path, notice: "数量を更新しました。"
    else
      cart_item.destroy
      redirect_to cart_path, notice: "商品をカートから削除しました。"
    end
  end

  private

  def set_cart
    if authenticated?
      @cart = Current.user.current_cart
    else
      session_id = session.id || session[:session_id] ||= SecureRandom.hex
      @cart = Cart.find_or_create_by(session_id: session_id)
    end
  end
end
