class Group < ApplicationRecord
    has_many :members, foreign_key: 'group_id'

    validates :group_name, presence: true

end
