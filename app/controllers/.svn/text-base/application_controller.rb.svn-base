class ApplicationController < ActionController::Base
  protect_from_forgery
  #adds all helpers from helpers/ to all controllers, can call from individual controllers, see railscasts 101 and docs
  helper :all
  before_filter :http_basic

  def index
    render :text => 'Welcome to the LikeList rails server.'
  end
  
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  # todo - should this go in a helper instead?
  def generate_activation_code(size = 6)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

  def fail(err)
    if err.class.name.ends_with?('::Errors')
      err.add(:trans_status, 'error')
    elsif err.kind_of?(Array)
      err.merge!(:trans_status => 'error')
    else
      respond_to do |type| 
        type.all  { render :nothing => true, :status => err } 
      end
      return
    end

    respond_to do |format|
      format.html { render :text => err }
      format.xml  { render :xml => err }
      format.json  { render :json => err }
    end
  end

  protected

  private

  def http_basic
    if AppConf.http_basic_username.present?
      authenticate_or_request_with_http_basic do |username, password|
        username == AppConf.http_basic_username && password == AppConf.http_basic_password
      end
      warden.custom_failure! if performed?
    end
  end
end

