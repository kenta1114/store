class SubscribersController < ApplicationController
  allow_unauthenticated_access
  before_action :set_product

  def create
    @product = Product.find(params[:product_id])
    @subscriber = @product.subscribers.build(subscriber_params)

    if @subscriber.save
      redirect_to @product, notice: "You are now subscribed to this product."
    else
      redirect_to @product, alert: "Subscription failed."
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
