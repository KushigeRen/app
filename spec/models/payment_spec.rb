require 'rails_helper'

RSpec.describe Payment, type: :model do
  before do
    @group = Group.create(
      group_id: 1,
      group_name: "test_group",
    )

    @creditor = Member.create(
      group_id: @group.id,
      member_name: "creditor",
    )

    @debtor = Member.create(
      group_id: @group.id,
      member_name: "debtor",
    )
  end

  it "債権者ID、債務者ID、金額があれば有効であること" do
    payment = Payment.new(
      creditor_member_id: @creditor.id,
      debtor_member_id: @debtor.id,
      amount: 3000,
    )
    expect(payment).to be_valid
  end

  it "債権者IDがなければ無効であること" do
    payment = Payment.new(creditor_member_id: nil)
    payment.valid?
    expect(payment.errors[:creditor_member_id]).to include("を入力してください")
  end

  it "債務者IDがなければ無効であること" do
    payment = Payment.new(debtor_member_id: nil)
    payment.valid?
    expect(payment.errors[:debtor_member_id]).to include("を入力してください")
  end

  it "金額がなければ無効であること" do
    payment = Payment.new(amount: nil)
    payment.valid?
    expect(payment.errors[:amount]).to include("を入力してください")
  end

  it "金額が1,000,000円以上であれば無効であること" do
    payment = Payment.new(amount: 1000000)
    payment.valid?
    expect(payment.errors[:amount]).to include("は0..999999の範囲に含めてください")
  end
end
