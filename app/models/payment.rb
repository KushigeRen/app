class Payment < ApplicationRecord
  # belongs_to :member, foreign_key: 'creditor_member_id', optional: true
  belongs_to :creditor_member, class_name: 'Member'
  belongs_to :debtor_member, class_name: 'Member'
  belongs_to :group,optional: true

  validates :creditor_member_id, presence: true
  validates :debtor_member_id, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { in: 0..999999 }
  validates :group_id, presence: true
  validates :payment_date, presence: true
  validates :description, presence: true
  validates :description, length: { in: 1..30 }

  # rubocop:disable Airbnb/OptArgParameters
  def self.ransackable_attributes(auth_object = nil)
    ["creditor_member_id", "debtor_member_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["creditor_member", "debtor_member"]
  end
  # rubocop:enable Airbnb/OptArgParameters
end
