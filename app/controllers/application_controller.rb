class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :liked_by_me?, :my_like

  def liked_by_me?(likeable)
    Like.where(
      user_id: current_user.id,
      likeable_id: likeable.id,
      likeable_type: likeable.class.name
    ).count > 0
  end

  def my_like(likeable)
    Like.where(
      user_id: current_user.id,
      likeable_id: likeable.id,
      likeable_type: likeable.class.name
    ).first
  end
  
  protected

  def configure_permitted_parameters
    attributes = [:name, :image]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
end