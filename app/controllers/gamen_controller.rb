class GamenController < ApplicationController

  respond_to :html

  def new
    @gamen = Gamen.new
  end

  def confirm
    @gamen = Gamen.new
    if not @gamen.save
      render :action => "new" 
    end
  end

  def reedit
    @gamen = Gamen.new
    render :action => "new"
  end

  def create
    @gamen = Gamen.new
    if not @gamen.save
      render :action => "new" 
    end
    redirect_to :action=>'complete'
  end

  def complete
    @data=Hash.new
    @data[:id] = 'data'
    respond_with  @data
  end

end
