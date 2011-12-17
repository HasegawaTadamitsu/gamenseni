class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def rescue_action_in_public(exception)

    case exception
    when  ActionController::RoutingError,
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
    when ParameterError
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
    when GamenseniError
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
    else
      super
    end
  end
end

