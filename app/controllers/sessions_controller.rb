class SessionsController < ApplicationController
  layout "sign_in"

  skip_before_action :authenticate_user!, except: [:destroy]
  skip_before_action :block_invalid_user!

  def new
    if user_signed_in?
      redirect_to after_signed_in_path_for(current_user), notice: "You already signed in"
    end
    set_koala_auth
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      redirect_to sign_in_and_redirect_for(user), notice: "Signed in successfully"
    else
      set_koala_auth
      flash.now[:alert] = "Invalid email/password"
      render :new
    end
  end

  def create_with_fb
    user = User.from_fb_token(params[:fb_access_token])
    if user
      redirect_to sign_in_and_redirect_for(user), notice: 'You have been registered successfully'
    else
      redirect_to sign_up_path, notice: "You don't have Facebook account associated with our records"
    end
  end

  def create_with_fb_m
    if params[:code]
      fb_token = Koala::Facebook::OAuth.new(ENV['FB_ID'], ENV['FB_SECRET'], sign_in_fb_m_url()).get_access_token(params[:code])
      user = User.from_fb_token(fb_token)
      if user
        redirect_to sign_in_and_redirect_for(user), notice: 'You have been registered successfully'
      else
        redirect_to sign_up_path, notice: "You don't have Facebook account associated with our records"
      end
    else
      redirect_to sign_up_path, alert: "You don't have Facebook account associated with our records"
    end
  end

  def destroy
    redirect_to sign_out_and_redirect_for(current_user), notice: "You have been signed out"
  end

  private
  def set_koala_auth
    @koala_auth = Koala::Facebook::OAuth.new(ENV['FB_ID'], ENV['FB_SECRET'])
  end
end
