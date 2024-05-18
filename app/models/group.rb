class Group < ApplicationRecord
    has_many :members, foreign_key: 'group_id'

end
