FactoryBot.define do
  factory :payment do
    amount {3000}
    payment_date {"2000-01-01"}
    description {"test"}
    association :creditor_member, factory: :member
    association :debtor_member, factory: :member
    association :group
  end
end
