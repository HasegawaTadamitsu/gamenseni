class GamenController < ApplicationController

  respond_to :html

  def new
    @gamen = Gamen.new
    set_all_select_hash @gamen
  end

  def confirm
    para = params[:gamen]
    if para.nil?
      redirect_to :action =>'new'
      return
    end
    @gamen = Gamen.new(para)
    if not @gamen.valid?
      set_all_select_hash @gamen
      render :action => "new" 
    end
    my_session = SessionMgr.new session
    my_session.set @gamen
  end

  def reedit
    my_session = SessionMgr.new session
    my_session.valid?
    @gamen = my_session.get
    set_all_select_hash @gamen
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
    select1_hash = [ 1=>"111",2=>"222"] 
    render :json => select1_hash
  end

  def chg_select2
    #todo
    set_all_select_hash
    render :chg_select
  end

  def chg_select3
    #todo
    set_select_hash_from_select3 10, 20, 30
    render :chg_select
  end

  private 
  def set_all_select_hash gamen
    @select1_hash = gamen.select1_hash
    @select2_hash = gamen.select2_hash
    @select3_hash = gamen.select3_hash
    @select4_hash = gamen.select4_hash
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
