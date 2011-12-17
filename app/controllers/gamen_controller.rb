class GamenController < ApplicationController

  respond_to :html

  def new
    @gamen = Gamen.new
  end

  def confirm
    para = params[:gamen]
    raise ParameterError.new("paramter is nill","para","nil") if para.nil?

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

  def chg_select
    selecter =params[:selecter]
    ken     = params[:ken]
    sikugun = params[:sikugun]
    machi   = params[:machi]
    
    gamen = Gamen.new
    adr = gamen.address_selecter
    ajax = adr.to_client_data selecter,ken,sikugun,machi
    render :json => ajax
  end

  def chg_zip
    selecter =params[:selecter]
    ken     = params[:ken]
    sikugun = params[:sikugun]
    machi   = params[:machi]
    gamen = Gamen.new
    adr = gamen.address_selecter
    ajax = adr.to_client_zip selecter,ken,sikugun,machi
    render :json => ajax
  end

  def chg_from_zip
    zip1 = params[:zip1]
    zip2 = params[:zip2]
    gamen = Gamen.new
    adr = gamen.address_selecter
    ajax = adr.to_client_from_zip zip1,zip2
    render :json => ajax
  end

  private 

end

