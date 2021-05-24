# frozen_string_literal: true

class ReportService
  class << self
    def new_register(value, user, status)
      Statement.create!(balance: value, user_id: user.id, action: status)
    end
  end
end
