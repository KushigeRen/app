class Payment < ApplicationRecord
    # belongs_to :member, foreign_key: 'creditor_member_id', optional: true
    belongs_to :creditor_member, class_name: 'Member', foreign_key: 'creditor_member_id'
    belongs_to :debtor_member, class_name: 'Member', foreign_key: 'debtor_member_id'
end
