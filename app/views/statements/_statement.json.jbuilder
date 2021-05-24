# frozen_string_literal: true

json.extract! statement, :id, :action, :user_id, :created_at, :updated_at
json.url statement_url(statement, format: :json)
