class Group < ApplicationRecord
  has_many :members

  validates :group_name, presence: true
  validates :group_name, length: { in: 1..15 }
end
