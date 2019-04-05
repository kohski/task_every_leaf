require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "sign upしたらUserがひとり増える" do
    count_before = User.count
    visit root_path
    click_link "Sign up"
    fill_in "名前", with: "test user"
    fill_in "メールアドレス", with: "test@test.com"
    fill_in "パスワード", with: "tttest"
    fill_in "パスワード確認", with: "tttest"
    click_button "登録"
    count_after = User.count
    expect(count_after).to eq(count_before + 1)
  end
end
