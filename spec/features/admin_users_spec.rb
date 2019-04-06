require 'rails_helper'

RSpec.feature "AdminUsers", type: :feature do
  context "ログイン状態" do
    before do
      @user = FactoryBot.create(:user)
      log_in(@user)
    end
    it "ユーザー一覧を取得できる" do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      create_task(user1,keyword:"first")
      create_task(user1,keyword:"second")
      create_task(user2,keyword:"first")
      create_task(user2,keyword:"second")
      visit admin_users_path
      trs = page.all('tr')
      expect(page.all('tr').size).to eq(4)
      trs[1..trs.count].each do |tr|
        expect(tr).to have_content("test user")
        expect(tr).to have_content(/test\d*@test.com/)
        expect(tr).to have_content(/\d*/)
        expect(tr).to have_link("詳細")
        expect(tr).to have_link("編集")
        expect(tr).to have_link("削除")
      end
    end    
    it "新しいユーザーを追加できる" do
      count_before = User.count
      visit admin_users_path
      click_link "新しいユーザー"
      fill_in "名前", with:"new test user"
      fill_in "メールアドレス", with: "newtest@test.com"
      fill_in "パスワード", with: "passowrd"
      fill_in "パスワード確認", with: "passowrd"
      click_button "登録"
      count_after = User.count 
      expect(count_after).to eq(count_before + 1)
    end
    it "ユーザーの詳細画面を表示する" do
      visit admin_users_path
      click_link "詳細"
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.email)
      expect(page).to have_link("ユーザー一覧")
    end
    it "ユーザー情報の編集機能のテスト" do
      visit admin_users_path
      click_link "編集"
      fill_in "名前", with: "edit user name"
      fill_in "メールアドレス", with:"edit@test.com"
      fill_in "パスワード", with:"password"
      fill_in "パスワード確認", with:"password"
      click_button "登録"
      expect(page).to have_content("edit user name")
      expect(page).to have_content("edit@test.com")      
    end
    it "ユーザー情報の削除ができる" do
      count_before = User.count
      visit admin_users_path
      click_link "削除"
      count_after = User.count 
      expect(count_after).to eq(count_before - 1)
    end

    it "ユーザー削除した場合、付随するタスクも削除される" do
      create_task(@user)
      count_before = Task.count
      visit admin_users_path
      click_link "削除"
      count_after = Task.count 
      expect(count_after).to eq(count_before - 1)
    end

  end
  context "未ログイン状態" do
    it "ユーザー一覧にアクセスするとログイン画面へ遷移する" do
      visit admin_users_path
      expect(page).to have_content("Log in")
    end
    it "ユーザー登録にアクセスするとログイン画面へ遷移する" do
      visit new_user_path
      expect(page).to have_content("Log in")
    end
  end
end
