require 'rails_helper'

RSpec.feature "AdminUsers", type: :feature do
  context "ログイン状態" do
    before do
      @user = FactoryBot.create(:user)
      log_in(@user)
    end
    context "admin user index" do
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
    end
    context "admin user create" do
      it 
    end
    context "admin user show" do
    end
    context "admin user edit" do
    end
    context "admin user destroy" do
    end
  end
  context "未ログイン状態" do
  
  end
end
