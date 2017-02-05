require "xmlrpc/client"

class Supervisor < ApplicationRecord
  belongs_to :user
  
  def processes
    server = XMLRPC::Client.new(hostname, "/RPC2", port)
    server.call("supervisor.getAllProcessInfo")
  end
end
