class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def rescue_action_in_public(exception)

    case exception
#    when  ActionController::RoutingError,
#      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404

    when GamenseniError
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
    else
      super
    end
  end
end

class GamenseniError < Exception
  attr_accessor :message
  def initialize arg
    @message = arg
  end
end

class BadParameterError < Exception
  attr_accessor :message
  def initialize arg
    @message = arg
  end
end

class SessionMgr
  def initialize session
    if session.nil?
      raise GamenseniError.new("bad session.")
    end
    @my_session  = session
    @data = session[:gamen]
  end

  def get
    @data
  end
  
  def valid?
    if @data.nil?
      raise GamenseniError.new("bad request? session is nil.")
    end
  end

  def set data
    @my_session[:gamen] = data
    @data = data
  end

  def kill
    @my_session[:gamen] = nil
    @data  = nil
  end

end
