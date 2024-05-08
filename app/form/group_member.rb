class GroupMember
    include ActiveModel::Model
    require 'securerandom'
    attr_accessor :group_name, :group_id, :token

    # member_name(連番)のattr_accessorを生成
    def self.create_member_accessors(count)
        count.times do |i|
            attr_accessor "member_name#{i+1}".to_sym
        end
    end

    def save(params)
        obj = FormatsController.new
        member_count = obj.get_member_name.count
        token = SecureRandom.hex(16)
        group = Group.create(group_id: group_id, group_name: group_name, token: token)
        group_page_url = "http://localhost:3000/group/#{token}"
        member_count.times do |i|
            Member.create(member_name: params[i], group_id: group_id)
        end
    end
end
