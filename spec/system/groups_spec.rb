require 'rails_helper'

RSpec.describe "Groups", type: :system do
  scenario "新しいグループを作成することができること" do
    expect  do
      visit root_path
      fill_in "group_member_group_name", with: "test_group"
      click_button "登録する"
      expect(page).to have_content "test_group"
    end.to change { Group.count }.by(1)
  end

  scenario "新しいグループを編集することができること", js: true do
    group = FactoryBot.create(:group)
    visit group_show_path(group.token)
    find('i.bi.bi-pen.edit-group').click
    fill_in "group_group_name", with: "edited_group"
    click_button "変更する"
    expect(page).to have_content "グループ情報を更新しました"
  end

  scenario "グループのURLをコピーできること", js: true do
    group = FactoryBot.create(:group)
    visit group_show_path(group.token)
    page.execute_script('navigator.clipboard = { writeText: function(text) { window.mockClipboard = text; } }')
    click_button "URLをコピー"
    clipboard_content = page.evaluate_script('window.mockClipboard')
    visit clipboard_content
    expect(page).to have_content "group"
  end
end
