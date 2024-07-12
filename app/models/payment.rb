class Payment < ApplicationRecord
    # belongs_to :member, foreign_key: 'creditor_member_id', optional: true
    belongs_to :creditor_member, class_name: 'Member', foreign_key: 'creditor_member_id'
    belongs_to :debtor_member, class_name: 'Member', foreign_key: 'debtor_member_id'

    validates :creditor_member_id, presence: true
    validates :debtor_member_id, presence: true
    validates :amount, presence: true

    def self.ransackable_attributes(auth_object = nil)
        ["creditor_member_id", "debtor_member_id"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["creditor_member", "debtor_member"]
    end
end
