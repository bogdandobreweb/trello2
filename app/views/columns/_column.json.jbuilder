json.extract! column, :id, :name, :board_id, :position, :created_at, :updated_at
json.url board_columns_url(column, format: :json)
