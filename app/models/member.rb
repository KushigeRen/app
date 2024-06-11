class Member < ApplicationRecord
    belongs_to :group, foreign_key: 'group_id'
    has_many :creditor_payments, class_name: 'Payment', foreign_key: 'creditor_member_id'
    has_many :debtor_payments, class_name: 'Payment', foreign_key: 'debtor_member_id'

    validates :member_name, presence: true
end
