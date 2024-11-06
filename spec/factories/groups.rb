FactoryBot.define do
  factory :group, aliases: [:owner] do
    group_name { "group" }
    token { SecureRandom.hex(16) }

    trait :group_created_at_least_60_days_ago do
      created_at { "2024-01-01 12:00:00" }
    end
  end
end
