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
      set_select_at_gamen_data @gamen
      render :action => "new" 
    end
    my_session = SessionMgr.new session
    my_session.set @gamen
  end

  def reedit
    my_session = SessionMgr.new session
    my_session.valid?
    @gamen = my_session.get
    set_select_at_gamen_data @gamen
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
    set_select_hash_from_select1 10 
    render :chg_select
  end

  def chg_select2
    #todo
    set_select_hash_from_select2 10, 20 
    render :chg_select
  end

  def chg_select3
    #todo
    set_select_hash_from_select3 10, 20, 30
    render :chg_select
  end

  private 
  # todo move to model
  def set_select_at_gamen_data arg
    @select1_hash = { 1  => 'abc', 2 => 'def' }
    
    if arg.select1_value
      set_select_hash_from_select1 arg.select1_value
    end
    if arg.select2_value
      set_select_hash_from_select2 arg.select1_value,
                                   arg.select2_value
    end
    if arg.select3_value
      set_select_hash_from_select3 arg.select1_value,
                                    arg.select2_value,
                                    arg.select3_value
    end
  end

  def set_all_select_hash
    # todo
    @select1_hash = { 1  => 'abc', 2 => 'def' }
    @select2_hash = Hash.new
    @select3_hash = Hash.new
    @select4_hash = Hash.new
  end
  
  def set_select_hash_from_select1 selecet1_value
    # todo
    @select2_hash = { 1 => 'aaa',2 =>'bbb' }
    @select3_hash = Hash.new
    @select4_hash = Hash.new
  end

  def set_select_hash_from_select2 selecet1_value,select2_value
    # todo
    @select3_hash = { 1 => 'cc',2 =>'d' }
    @select4_hash = Hash.new
  end

  def set_select_hash_from_select3 selecet1_value,select2_value,select3_value
    # todo
    @select4_hash = { 2 =>"aa", 3=>"bb"}
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
