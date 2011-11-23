class GamenController < ApplicationController

  respond_to :html

  def new
    @gamen = session[:gamen]
    if @gamen.nil?
      @gamen = Gamen.new
    end
  end

  def confirm
    para = params[:gamen]
    if para.nil?
      raise "bad request? params is nil."
    end
    @gamen = Gamen.new(para)
    session[:gamen] = @gamen
    if not @gamen.save
      render :action => "new" 
    end
  end

  def reedit
    @gamen = session[:gamen]
    if @gamen.nil?
      raise "bad request? session is nil."
    end
    render :action => "new"
  end

  def create
    @gamen = session[:gamen]
    if @gamen.nil?
      raise "bad request? session is nil."
    end
    if not @gamen.save
      render :action => "new" 
    end
    redirect_to :action=>'complete'
  end

  def complete
    @gamen = session[:gamen]
    if @gamen.nil?
      raise "bad request? session is nil."
    end
    session[:gamen] = nil
    @data=Hash.new
    @data[:id] = 'data'
    respond_with  @data
  end

end
