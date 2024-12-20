FactoryBot.define do
  factory :payment do
    amount { 3000 }
    payment_date { "2024-01-01" }
    description { "test" }
    created_at { Time.current }
    association :creditor_member, factory: :member
    association :debtor_member, factory: :member
    association :group

    after(:create) do |payment|
      payment.creditor_member = FactoryBot.create(:member, group: payment.group)
      payment.debtor_member = FactoryBot.create(:member, group: payment.group)
    end
  end
end
