# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'a9d38cfcec93e37aa3f7a539c9a25e42'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  before_filter :set_current_locate
  before_filter :configure_charsets
  before_filter :authenticate
  before_filter :set_current_user
  helper_method :current_user

  filter_parameter_logging :password

protected

  def set_current_locate
    session[:locate] ||= "en"
    I18n.locale = session[:locate]
  end

  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end

 def set_current_user
    User.current_user_id = session[:user]
  end


def authenticate
  case request.format # para libera acesso a rss
  when Mime::RSS
      unless authenticate_with_http_basic { |u, p| User.find_by_login_and_password(u, p) }
        request_http_basic_authentication
      end
   else
    unless session[:user]
     session[:return_to] = request.request_uri
     redirect_to login_path
    end
   end
end

#884080003268755
          #69464

  # Especifico para Mysql
  def configure_charsets 
	headers["Content-Type"] = "text/html; charset=utf-8" 
	suppress(ActiveRecord::StatementInvalid) do 
	  ActiveRecord::Base.connection.execute 'SET NAMES UTF8' 
	end
  end 

protected
   class << self

  attr_reader :parents

  def parent_resources(*parents)
      @parents = parents
  end
end

  def parent_id(parent)
    request.path_parameters["#{ parent }_id"]
  end

  def parent_type
    self.class.parents.detect { |parent| parent_id(parent) }
  end
   
  def parent_object
    parent_class && parent_class.find_by_id(parent_id(parent_type))
  end

  def parent_class
    parent_type && parent_type.to_s.classify.constantize
  end

end
