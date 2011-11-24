class GamenController < ApplicationController

  respond_to :html

  def new
    @gamen = Gamen.new
  end

  def confirm
    para = params[:gamen]
    if para.nil?
      raise "bad request? params is nil."
    end
    @gamen = Gamen.new(para)
    if not @gamen.valid?
      render :action => "new" 
    end
    my_session = SessionMgr.new session
    my_session.set @gamen
  end

  def reedit
    my_session = SessionMgr.new session
    my_session.valid?
    @gamen = my_session.get
    my_session.kill
    render :action => "new"
  end

  def create
    my_session = SessionMgr.new session
    my_session.valid?

    @gamen = my_session.get
    if not @gamen.save
      render :action => "new" 
    end
    redirect_to :action=>'complete'
  end

  def complete
    my_session = SessionMgr.new session
    my_session.valid?

    gamen = my_session.get
    @data=Hash.new
    @data[:id] = gamen.title

    my_session.kill
    respond_with  @data
  end

  private 


end
class SessionMgr
  def initialize session
    if session.nil?
      raise "bad session."
    end
    @my_session  = session
    @data = session[:gamen]
  end

  def get
    @data
  end
  
  def valid?
    if @data.nil?
      raise "bad request? session is nil."
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
