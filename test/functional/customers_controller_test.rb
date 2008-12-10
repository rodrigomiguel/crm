require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  
#  def setup
#    super
#    @request.session[:user] = users(:one).id
#  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_customer
    assert_difference('Customer.count') do
      post :create, :customer => {
	:name => "Diego Gura Marczal", :description => "Olá Diego Marczal", :rating => 3, 
	:created_at => Time.now,  :updated_at => Time.now, :phone_country_code => 10,
	:phone_area_code => 10, :phone_number => "100"
      }
    end

    assert_redirected_to customer_path(assigns(:customer))
  end

  def test_should_show_customer
    get :show, :id => customers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => customers(:one).id
    assert_response :success
  end

  def test_should_update_customer
    put :update, :id => customers(:one).id, :customer => { }
    assert_redirected_to customer_path(assigns(:customer))
  end

  def test_should_destroy_customer
    assert_difference('Customer.count', -1) do
      delete :destroy, :id => customers(:one).id
    end

    assert_redirected_to customers_path
  end
end
