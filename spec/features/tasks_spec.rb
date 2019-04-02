require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  scenario "タスク一覧のテスト" do
    FactoryBot.create(:task)
    visit root_path
    expect(page).to have_content "test task"
    expect(page).to have_content "test task content"
  end

  scenario "タスク作成のテスト" do
    visit root_path
    click_link "新しいタスク"
    expect {
      fill_in "task_name", with: "test name"
      fill_in "task_content", with: "test content" 
      click_button "登録"
      expect(page).to have_content "test name"
      expect(page).to have_content "test content"
    }.to change(Task, :count).by(1)

  end

  scenario "任意のタスク詳細画面に遷移したら、該当タスクの内容が表示されたページに遷移する" do
    FactoryBot.create(:task)
    visit root_path
    click_link "詳細"
    expect(page).to have_content "test task"
    expect(page).to have_content "test task content"  
  end

end
