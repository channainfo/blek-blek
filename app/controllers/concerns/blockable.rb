module Blockable
  extend ActiveSupport::Concern

  included do
    before_action :block_invalid_user!
  end

  def block_invalid_user!
    if current_user && current_user.blocked
      redirect_blocked_user
    end
  end

  def redirect_blocked_user
    flash[:info] = "Your account has been suspended, Please contact us"
    redirect_to blocked_path
  end
end