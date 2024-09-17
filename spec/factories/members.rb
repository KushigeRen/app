FactoryBot.define do
  factory :member do
    sequence(:member_name) { |n| "member#{n}" }
    association :group
  end
end
