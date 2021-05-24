# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # MODEL RELATIONSHIP
  has_many :statements

  # ATTRS
  attr_accessor :value, :target_user, :start_date, :end_date

  # MODEL VALIDATES
  validates :full_name, length: { minimum: 3, maximum: 50 }, allow_blank: false
  validates :email, length: { minimum: 5, maximum: 70 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_inclusion_of :blocked, in: [true, false]

  # SCOPE
  scope :get_all_users_except_me, ->(me) { all.where.not(id: me).order(:name) }
end
