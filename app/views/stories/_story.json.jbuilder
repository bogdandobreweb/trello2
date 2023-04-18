json.extract! story, :id, :title, :column_id, :position, :description, :created_at, :updated_at
json.url board_column_stories_url(story, format: :json)
