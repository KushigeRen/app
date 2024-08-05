class GroupMember
    include ActiveModel::Model
    validates :group_name, presence: true
    require 'securerandom'
    attr_accessor :group_name, :group_id, :token

    # member_name_keysのattr_accessorを生成
    def self.create_member_accessors(member_name_keys)
        member_name_keys.each do |key|
            attr_accessor key.to_sym
        end
    end

    def save(params)
        obj = FormatsController.new
        member_count = obj.get_member_name.count
        token = SecureRandom.hex(16)
        group = Group.create(group_id: group_id, group_name: group_name, token: token)
        member_count.times do |i|
            Member.create(member_name: params[i], group_id: group_id)
        end
    end
end
