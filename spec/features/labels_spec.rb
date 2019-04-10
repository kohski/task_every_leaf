require 'rails_helper'

RSpec.feature "Labels", type: :feature do
  context "未ログイン時" do
scenario "labels#indexにアクセスしてもログイン画面へリダイレクトされる" do
      visit labels_path
      expect(page).to have_content("ログインまたはサインアップしてください")
      expect(page).to have_content("Log in")
    end
scenario "labels#newにアクセスしてもログイン画面へリダイレクトされる" do
      visit new_label_path
      expect(page).to have_content("ログインまたはサインアップしてください")
      expect(page).to have_content("Log in")
    end 
  end

  context "ログイン時" do
    before do
      @user = FactoryBot.create(:user)
      log_in(@user)
    end

scenario "index画面の新しいラベルボタンからラベルを一枚登録できる" do 
      click_link "ラベル一覧"
      click_link "新しいラベル"
      fill_in "名前", with: "test label A"
      fill_in "内容", with: "test label A content"
      click_button "登録"
      expect(page).to have_content("test label A")
    end

scenario "index画面にアクセスしたら自分のラベルだけ表示される" do
      # ログイン済みユーザーでラベルを登録
      click_link "ラベル一覧"
      click_link "新しいラベル"
      fill_in "名前", with: "test label A"
      fill_in "内容", with: "test label A content"
      click_button "登録"
      # 別ユーザでログインとラベル登録
      click_link "Log out"
      another_user = FactoryBot.create(:user)
      log_in(another_user)
      click_link "ラベル一覧"
      click_link "新しいラベル"
      fill_in "名前", with: "test label B"
      fill_in "内容", with: "test label B content"
      click_button "登録"
      # label一覧ページを検証
      expect(page).to have_content("test label B")
      expect(page).to_not have_content("test label A")
    end


scenario "index画面の削除ボタンからラベルを一枚削除できる" do
      label = create_label(@user)
      visit labels_path
      click_link "削除"
      expect(page).to_not have_content(label.name)
      expect(page).to_not have_content(label.content)
    end

scenario "index画面の編集ボタンからラベルを一枚編集できる" do
      label = create_label(@user)
      visit labels_path
      click_link "編集"
      fill_in "名前", with: "#{label.name} edit"
      fill_in "内容", with: "#{label.content} edit"
      click_button "登録"
      expect(page).to have_content(label.name + " edit")
      expect(page).to have_content(label.content + " edit")
    end
  end
end
