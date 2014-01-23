class RegistrationsController < Devise::RegistrationsController
  def create
    logger.info "inside registrations_controller.create"
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  private
  
  def build_resource(*args)
    super
    logger.info "inside registrations_controller.build_resource: after call to super:" + @user.to_yaml
    if session[:omniauth]
      logger.info "Auth:#{session[:omniauth].to_yaml}"
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    else
      user = User.new
      #x = Authentication.new :sn_id => 0, :sn_user_id => @user.id, :user_id => @user.id
      #@user.email_authentication = x
      logger.info "inside registrations_controller.build_resource: omniauth not set!"
    end
  end
end
