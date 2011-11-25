class GamenController < ApplicationController

  respond_to :html

  def new
    @gamen = Gamen.new
    set_all_select_hash
  end

  def confirm
    para = params[:gamen]
    if para.nil?
      raise "bad request? params is nil."
    end
    @gamen = Gamen.new(para)
    if not @gamen.valid?
      set_all_select_hash
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

    set_all_select_hash
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


  def chg_select1
    #todo
    @select2_hash = { 1 => 'aaa',2 =>'bbb' }
    @select3_hash = Hash.new
    @select4_hash = Hash.new
    render :chg_select
  end

  def chg_select2
    #todo
    @select3_hash = { 1 => 'cc',2 =>'d' }
    @select4_hash = Hash.new
    render :chg_select
  end

  def chg_select3
    #todo
    @select4_hash = { 1 => 'ed',2 =>'ff' }
    render :chg_select
  end

  private 
  def set_all_select_hash
    # todo
    @select1_hash = { 1  => 'abc', 2 => 'def' }
    @select2_hash = Hash.new
    @select3_hash = Hash.new
    @select4_hash = Hash.new
  end
  
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
