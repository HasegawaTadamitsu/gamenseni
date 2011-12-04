require 'spec_helper'

describe GamenController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'confirm'" do
    it "no param is raise" do
      lambda{ get( 'confirm' ) }.should 
          raise_error( GamenseniError)
    end
  end

  describe "GET 'reedit'" do
    it "no session is raise" do
      lambda{ get( 'reedit' ) }.should 
          raise_error( GamenseniError)
    end
  end

  describe "GET 'create'" do
    it "raise" do
      lambda{ get( 'create' ) }.should 
          raise_error( GamenseniError)
    end
  end

  describe "GET 'complete'" do
    it "raise" do
      lambda{ get( 'complete' ) }.should 
          raise_error( GamenseniError)
    end
  end

  describe "GET 'chg_select'" do
    it "returns http success" do
      lambda{get('chg_select')}.should 
          raise_error( BadParameterError)
    end
  end

  describe "GET 'chg_zip'" do
    it "returns http success" do
      lambda{get('chg_zip')}.should 
          raise_error( GamenseniError)
    end
  end

end
