json.extract! todo, :id, :name, :done, :created_at, :updated_at
json.url todo_url(todo, format: :json)
