class SessionsController < Devise::SessionsController

  # GET /resource/sign_in
  def new
    render :layout => 'layouts/blank', :template => 'devise/sessions/new'
  end

  # POST /resource/sign_in
  def create
    authentication = Authentication.find_by_sn_id_and_email(0, params[:user]['email'])
    set_flash_message :notice, :signed_in
    sign_in_and_redirect(:user, authentication.user)
  end

  # GET /resource/sign_out
  def destroy
    set_flash_message :notice, :signed_out if signed_in?(:user)
    sign_out_and_redirect(:user)
  end

end