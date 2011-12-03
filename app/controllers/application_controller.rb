class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def local_request?
    false
  end

  def rescue_action_in_public(exception)
    case exception
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
