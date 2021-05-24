# frozen_string_literal: true

class Statement < ApplicationRecord
  # MODEL RELATIONSHIP
  belongs_to :user
  # MODEL VALIDATES
  validates :action, length: { minimum: 3, maximum: 20 }, allow_blank: false
  # CUSTOM METHODS
  class << self
    def by_period(first_day, last_day)
      where(created_at: (first_day..last_day))
    end
  end
end
