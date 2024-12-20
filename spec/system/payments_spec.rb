require 'rails_helper'

RSpec.describe "Payments", type: :system do
  before do
    @payments = FactoryBot.create_list(:payment, 3)
    @group = Group.find(@payments[0].group_id)
    @members = Member.where(group_id: @group.group_id)
    visit group_show_path(@group.token)
  end

  scenario "支払い明細を追加できること", js: true do
    find('i.bi.bi-plus-circle.new-payment').click
    select @members[0].member_name, from: "payment[creditor_member_id]"
    select @members[1].member_name, from: "payment[debtor_member_id]"
    fill_in "payment_amount", with: 10000
    fill_in "payment_description", with: "test"
    click_button "登録する"
    expect(page).to have_content "支払い明細を作成しました"
  end

  scenario "支払い明細を編集できること", js: true do
    find('i.bi.bi-three-dots-vertical').click
    find('.dropdown-item.edit').click
    select @members[0].member_name, from: "payment[creditor_member_id]"
    select @members[1].member_name, from: "payment[debtor_member_id]"
    fill_in "payment_description", with: "edited"
    click_button "登録する"
    expect(page).to have_content "支払い明細を更新しました"
  end

  scenario "支払いを完了できること", js: true do
    page.accept_confirm do
      find('i.bi.bi-check-circle').click
    end
    expect(page).to have_content "支払いが完了しました"
  end

  scenario "支払いをまとめて完了できること", js: true do
    all('input[type="checkbox"]').each do |checkbox|
      checkbox.check
    end
    page.accept_confirm do
      click_button "まとめて完了"
    end
    expect(page).to have_content "選択された支払いを完了しました。"
  end

  scenario "支払い明細を絞り込み検索できること", js: true do
    find('i.bi.bi-plus-circle.new-payment').click
    select @members[0].member_name, from: "payment[creditor_member_id]"
    select @members[1].member_name, from: "payment[debtor_member_id]"
    fill_in "payment_amount", with: 9999
    fill_in "payment_description", with: "test"
    click_button "登録する"
    expect(page).to have_content "支払い明細を作成しました"

    select @members[0].member_name, from: "q[creditor_member_member_name_eq]"
    page.execute_script("document.querySelector('form').dispatchEvent(new Event('submit', { bubbles: true }))")
    expect(page).to have_selector('#creditor_member', count: 1)

    select @members[1].member_name, from: "q[creditor_member_member_name_eq]"
    page.execute_script("document.querySelector('form').dispatchEvent(new Event('submit', { bubbles: true }))")
    expect(page).to have_selector('#creditor_member', count: 0)
  end
end
