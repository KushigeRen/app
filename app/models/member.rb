class Member < ApplicationRecord
  belongs_to :group
  has_many :creditor_payments, class_name: 'Payment', foreign_key: 'creditor_member_id', dependent: :restrict_with_error
  has_many :debtor_payments, class_name: 'Payment', foreign_key: 'debtor_member_id', dependent: :restrict_with_error

  validates :member_name, presence: true
  validates :group_id, presence: true
  validates :member_name, length: { in: 1..8 }

  # rubocop:disable Airbnb/OptArgParameters
  def self.ransackable_attributes(auth_object = nil)
    ["member_name"]
  end
  # rubocop:enable Airbnb/OptArgParameters
end
