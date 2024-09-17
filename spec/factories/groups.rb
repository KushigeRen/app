FactoryBot.define do
  factory :group, aliases: [:owner] do
    group_name { "group" }
    token { SecureRandom.hex(16) }
  end
end
