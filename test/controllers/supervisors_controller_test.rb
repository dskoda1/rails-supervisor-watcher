require 'test_helper'

class SupervisorsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login
    @supervisor = get_supervisor(@user)
    @supervisor.save
    assert(@supervisor.persisted?)
    stub_request(:post, "http://localhost:8082/RPC2").
      with(:body => "<?xml version=\"1.0\" ?><methodCall><methodName>supervisor.getAllProcessInfo</methodName><params/></methodCall>\n",
       :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Connection'=>'keep-alive', 'Content-Length'=>'110', 'Content-Type'=>'text/xml; charset=utf-8', 'User-Agent'=>'XMLRPC::Client (Ruby 2.3.0)'}).
      to_return(:body => "<?xml version='1.0'?>\n<methodResponse>\n<params>\n<param>\n<value><array><data>\n<value><struct>\n<member>\n<name>description</name>\n<value><string>pid 7263, uptime 0:00:38</string></value>\n</member>\n<member>\n<name>pid</name>\n<value><int>7263</int></value>\n</member>\n<member>\n<name>stderr_logfile</name>\n<value><string>/tmp/sleep-stderr---supervisor-J7jOMO.log</string></value>\n</member>\n<member>\n<name>stop</name>\n<value><int>0</int></value>\n</member>\n<member>\n<name>logfile</name>\n<value><string>/tmp/sleep-stdout---supervisor-Yh9c2j.log</string></value>\n</member>\n<member>\n<name>exitstatus</name>\n<value><int>0</int></value>\n</member>\n<member>\n<name>spawnerr</name>\n<value><string></string></value>\n</member>\n<member>\n<name>now</name>\n<value><int>1486317559</int></value>\n</member>\n<member>\n<name>group</name>\n<value><string>sleep</string></value>\n</member>\n<member>\n<name>name</name>\n<value><string>sleep</string></value>\n</member>\n<member>\n<name>statename</name>\n<value><string>RUNNING</string></value>\n</member>\n<member>\n<name>start</name>\n<value><int>1486317521</int></value>\n</member>\n<member>\n<name>state</name>\n<value><int>20</int></value>\n</member>\n<member>\n<name>stdout_logfile</name>\n<value><string>/tmp/sleep-stdout---supervisor-Yh9c2j.log</string></value>\n</member>\n</struct></value>\n</data></array></value>\n</param>\n</params>\n</methodResponse>\n" )
  end
  
  def params
    { supervisor: { 
        hostname: @supervisor.hostname, 
        name: @supervisor.name, 
        port: @supervisor.port
      } }
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

  test "should create supervisor, assigning user from session" do
    assert_difference('Supervisor.count') do
      post supervisors_url, 
        params: params
    end
    assert_redirected_to supervisor_url(Supervisor.last)
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
