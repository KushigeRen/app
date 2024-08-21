class GroupMember
  include ActiveModel::Model
  validates :group_name, presence: true
  require 'securerandom'
  attr_accessor :group_name, :token

  # member_name_keysのattr_accessorを生成
  def self.create_member_accessors(member_name_keys)
    member_name_keys.each do |key|
      attr_accessor key.to_sym
    end
  end

  def save(params)
    member_count = FormatsController.member_name.count
    token = SecureRandom.hex(16)
    Group.create(group_name: group_name, token: token)
    member_count.times do |i|
      Member.create(member_name: params[i], group_id: Group.order(group_id: :desc).first.group_id)
    end
  end
end
