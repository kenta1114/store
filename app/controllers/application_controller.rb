class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  around_action :switch_locale
  before_action :set_current_cart
  
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  private

  def set_current_cart
    if authenticated?
      @current_cart = Current.user.current_cart
    else
      session_id = session.id || session[:session_id] ||= SecureRandom.hex
      @current_cart = Cart.find_or_create_by(session_id: session_id)
    end
  end
end
