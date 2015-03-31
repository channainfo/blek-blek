class RegistrationsController < ApplicationController
  layout "sign_in"

  skip_before_action :authenticate_user!

  def new
    if user_signed_in?
      redirect_to after_signed_in_path_for(current_user), notice: "You already signed in"
    end
    @user = User.new.with_site_sign_up_step
    set_koala_auth
  end

  def create
    @user = User.new(filter_params).with_site_sign_up_step
    if @user.save
      send_welcome_messsage(@user)
      redirect_to sign_in_and_redirect_for(@user), notice: 'You have been registered successfully'
    else
      flash.now[:alert] = "Failed to registered"
      set_koala_auth
      render :new
    end

  end

  def create_with_fb
    user = User.create_from_fb_token(params[:fb_access_token])
    send_welcome_messsage(user)
    # check email if current user exist
    redirect_to sign_in_and_redirect_for(user), notice: 'You have been registered successfully'
  end

  def create_with_fb_m
    if params[:code]
      fb_token = Koala::Facebook::OAuth.new(ENV['FB_ID'], ENV['FB_SECRET'], sign_up_fb_m_url()).get_access_token(params[:code])
      user = User.create_from_fb_token(fb_token)
      send_welcome_messsage(user)
      redirect_to after_signed_in_path_for(user), notice: 'You have been registered successfully'
    else
      redirect_to sign_up_path, alert: "Login with facebook was rejected"
    end
  end

  private
  def set_koala_auth
    @koala_auth = Koala::Facebook::OAuth.new(ENV['FB_ID'], ENV['FB_SECRET'])
  end

  def filter_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :user_name, :gender, :password, :password_confirmation)
  end

  def send_welcome_messsage(user)
    UserMailer.welcome_member(user).deliver_later
  end
end