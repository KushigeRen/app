class Member < ApplicationRecord
    belongs_to :group, foreign_key: 'group_id'
    has_many :creditor_payments, class_name: 'Payment', foreign_key: 'creditor_member_id', dependent: :restrict_with_error
    has_many :debtor_payments, class_name: 'Payment', foreign_key: 'debtor_member_id', dependent: :restrict_with_error

    validates :member_name, presence: true

    def self.ransackable_attributes(auth_object = nil)
        ["member_name"]
    end
end
