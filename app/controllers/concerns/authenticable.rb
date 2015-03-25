module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :restrict_staging!
    before_action :authenticate_user!
  end

  def restrict_staging!
    authenticate_or_request_with_http_basic do |username, password|
      [username, password] == [ENV['STAGING_USER'], ENV['STAGING_PASSWORD']]
    end
  end

  def current_user
    if user_signed_in?
      @current_user ||= User.find(session[:user_id])
    end
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to sign_in_path, alert: "You need to sign in first"
    end
  end

  def after_signed_in_path_for(user=nil)
    return user.admin? ? admin_root_path : root_path if user
    return root_path
  end

  def after_signed_out_path_for(user=nil)
    sign_in_path
  end

  def user_signed_in?
    session[:user_id].present?
  end

  def sign_in(user)
    user.last_signed_in_at = Time.zone.now
    user.save(validate: false)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def sign_in_and_redirect_for(user)
    sign_in(user)
    after_signed_in_path_for(user)
  end

  def sign_out_and_redirect_for(user)
    sign_out
    after_signed_out_path_for(user)
  end

end