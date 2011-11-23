require 'test_helper'

class GamenControllerTest < ActionController::TestCase
  setup do
    @gaman = gamen(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gamen)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gaman" do
    assert_difference('Gaman.count') do
      post :create, :gaman => @gaman.attributes
    end

    assert_redirected_to gaman_path(assigns(:gaman))
  end

  test "should show gaman" do
    get :show, :id => @gaman.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @gaman.to_param
    assert_response :success
  end

  test "should update gaman" do
    put :update, :id => @gaman.to_param, :gaman => @gaman.attributes
    assert_redirected_to gaman_path(assigns(:gaman))
  end

  test "should destroy gaman" do
    assert_difference('Gaman.count', -1) do
      delete :destroy, :id => @gaman.to_param
    end

    assert_redirected_to gamen_path
  end
end
