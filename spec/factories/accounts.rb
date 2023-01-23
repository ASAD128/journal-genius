FactoryBot.define do
  factory :account do
    sequence(:name, 100) { |n| "employee#{n}" }
    sequence(:account_number, 1000) { |n| "account#{n}" }
  end
end
