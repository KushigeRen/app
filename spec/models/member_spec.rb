require 'rails_helper'

RSpec.describe Member, type: :model do
  it "メンバー名,グループIDがあれば有効な状態であること" do
    Group.create(
      group_id: 1,
      group_name: "group",
    )

    member = Member.new(
      group_id: 1,
      member_name: "member",
    )
    expect(member).to be_valid
  end

  it "メンバー名がなければ無効であること" do
    member = Member.new(member_name: nil)
    member.valid?
    expect(member.errors[:member_name]).to include("を入力してください")
  end

  it "グループIDがなければ無効であること" do
    member = Member.new(group_id: nil)
    member.valid?
    expect(member.errors[:group_id]).to include("を入力してください")
  end

  it "メンバー名が9文字以上であれば無効であること" do
    member = Member.new(member_name: "abcdefghi")
    member.valid?
    expect(member.errors[:member_name]).to include("は8文字以内で入力してください")
  end
end
