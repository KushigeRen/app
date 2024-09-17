require 'rails_helper'

RSpec.describe Payment, type: :model do
  group = FactoryBot.create(:group)
  payment = FactoryBot.create(:payment)

  it "債権者ID、債務者ID、金額、支払い日、メモがあれば有効であること" do
    expect(FactoryBot.build(
      :payment, creditor_member_id: payment.creditor_member_id,
                debtor_member_id: payment.debtor_member_id,
                group: group
    )).to be_valid
  end

  it "債権者IDがなければ無効であること" do
    payment = FactoryBot.build(:payment, creditor_member_id: nil)
    payment.valid?
    expect(payment.errors[:creditor_member_id]).to include("を入力してください")
  end

  it "債務者IDがなければ無効であること" do
    payment = FactoryBot.build(:payment, debtor_member_id: nil)
    payment.valid?
    expect(payment.errors[:debtor_member_id]).to include("を入力してください")
  end

  it "金額がなければ無効であること" do
    payment = FactoryBot.build(:payment, amount: nil)
    payment.valid?
    expect(payment.errors[:amount]).to include("を入力してください")
  end

  it "金額が1,000,000円以上であれば無効であること" do
    payment = FactoryBot.build(:payment, amount: 1000000)
    payment.valid?
    expect(payment.errors[:amount]).to include("は0..999999の範囲に含めてください")
  end

  it "支払日がなければ無効であること" do
    payment = FactoryBot.build(:payment, payment_date: nil)
    payment.valid?
    expect(payment.errors[:payment_date]).to include("を入力してください")
  end

  it "メモがなければ無効であること" do
    payment = FactoryBot.build(:payment, description: nil)
    payment.valid?
    expect(payment.errors[:description]).to include("を入力してください")
  end

  it "メモが31文字以上であれば無効であること" do
    payment = FactoryBot.build(:payment, description: "1234567890123456789012345678901")
    payment.valid?
    expect(payment.errors[:description]).to include("は30文字以内で入力してください")
  end
end
