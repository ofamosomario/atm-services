# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email    { Faker::Internet.email }
    password { '123123' }
    password_confirmation { '123123' }
    blocked { false }
  end
end
