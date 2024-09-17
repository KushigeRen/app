require 'rails_helper'

RSpec.describe "Members", type: :system do
  before do
    @member = FactoryBot.create(:member)
    @group = Group.find(@member.group_id)
    visit group_show_path(@group.token)
  end

  scenario "グループにメンバーが追加できること", js: true do
    find('i.bi.bi-plus-circle.add-member').click
    fill_in "member_member_name", with: "user1"
    click_button "登録する"
    expect(page).to have_content "user1"
  end

  scenario "メンバーを削除できること", js: true do
    click_link(href: "/formats/#{@member.member_id}/edit")
    page.accept_confirm do
      click_button "削除する"
    end
    expect(page).to have_content "メンバー情報を削除しました。"
  end

  scenario "メンバーを編集できること", js: true do
    click_link(href: "/formats/#{@member.member_id}/edit")
    click_button "変更する"
    expect(page).to have_content "メンバー情報を更新しました。"
  end
end
