require 'rails_helper'

RSpec.describe Group, type: :model do
  it "グループ名があれば有効な状態であること" do
    expect(FactoryBot.build(:group)).to be_valid
  end

  it "グループ名がなければ無効であること" do
    group = FactoryBot.build(:group, group_name: nil)
    group.valid?
    expect(group.errors[:group_name]).to include("を入力してください")
  end

  it "グループ名が16文字以上であれば無効であること" do
    group = FactoryBot.build(:group, group_name: "abcdefghijklmnop")
    group.valid?
    expect(group.errors[:group_name]).to include("は15文字以内で入力してください")
  end
end
