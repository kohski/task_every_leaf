require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  scenario "ログインしたら、ユーザーの詳細画面に遷移する" do
    user = FactoryBot.create(:user)
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password 
    click_button "登録"
    expect(page).to have_content "ユーザー詳細"
    expect(page).to have_content "ログインしました"
  end

  scenario "不正なパスワードの場合、もう一度ログイン画面をレンダーする" do
    user = FactoryBot.create(:user)
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password+"error"
    click_button "登録"
    save_and_open_page
    expect(page).to have_content "Log in"
    expect(page).to have_content "ログイン失敗しました"
  end

  scenario "ログアウトしたらログイン画面へ遷移する" do
    user = FactoryBot.create(:user)
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "登録"
    click_link "Log out"
    expect(page).to have_content "Log in"
    expect(page).to have_content "ログアウトしました"
  end

end
