json.extract! supervisor, :id, :user_id, :name, :hostname, :port, :created_at, :updated_at
json.url supervisor_url(supervisor, format: :json)