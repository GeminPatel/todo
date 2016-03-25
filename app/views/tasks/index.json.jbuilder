json.array!(@tasks) do |task|
  json.extract! task, :id, :user_id, :content, :priority_id, :deadline, :category
  json.url task_url(task, format: :json)
end
