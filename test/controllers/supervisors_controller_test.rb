require 'test_helper'

class SupervisorsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login
    @supervisor = get_supervisor(@user)
    @supervisor.save
    assert(@supervisor.persisted?)
  end
  
  def params
    { supervisor: { 
        hostname: @supervisor.hostname, 
        name: @supervisor.name, 
        port: @supervisor.port, 
        user_id: @supervisor.user_id  } }
  end

  test "should get index" do
    get supervisors_url
    assert_equal(assigns(:supervisors), [@supervisor])
    assert_response :success
  end
  
  test "should not get another users supervisors" do
    # Create a supervisor for another user
    other_user = users(:user2)
    sup = get_supervisor(other_user, 'otherhost')
    sup.save!

    get supervisors_url
    assert_equal( [@supervisor], assigns(:supervisors))
    assert_response :success
  end

  test "should get new" do
    get new_supervisor_url
    assert_response :success
  end

  test "should create supervisor" do
    assert_difference('Supervisor.count') do
      post supervisors_url, 
        params: params
    end
    assert_redirected_to supervisor_url(Supervisor.last)
  end

  test "should not create supervisor missing user" do
    assert_no_difference('Supervisor.count') do
      changed_params = params
      changed_params[:supervisor][:user_id] = nil
      post supervisors_url, params: changed_params
    end
    assert_response 400
  end  
  

  test "should show supervisor" do
    get supervisor_url(@supervisor)
    assert_response :success
  end

  test "should get edit" do
    get edit_supervisor_url(@supervisor)
    assert_response :success
  end

  test "should update supervisor" do
    @supervisor.name = "updated_name"
    patch supervisor_url(@supervisor), params: params
    assert_redirected_to supervisor_url(@supervisor)
    assert_equal(@supervisor.name, "updated_name")
  end

  test "should destroy supervisor" do
    assert_difference('Supervisor.count', -1) do
      delete supervisor_url(@supervisor)
    end

    assert_redirected_to supervisors_url
  end
end
