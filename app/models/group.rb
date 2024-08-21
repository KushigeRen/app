class Group < ApplicationRecord
  has_many :members

  validates :group_name, presence: true
end
