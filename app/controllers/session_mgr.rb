class SessionMgr
  def initialize session
    if session.nil?
      raise GamenseniError.new("bad session.")
    end
    @my_session  = session
    @data = session[:gamen]
  end

  def get
    raise GamenseniError.new("session is nil") if @data.nil?
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

  def delete_sesstion
#    Session.delete(:condition="updated_at < now() +'-30 minutes'")
  end
end
