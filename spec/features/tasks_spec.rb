require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  before do
    @user = FactoryBot.create(:user)
    log_in(@user)
  end

  scenario "タスク一覧のテスト" do
    create_task(@user)
    visit root_path
    expect(page).to have_content "task name no.1"
    expect(page).to have_content "task content no.1"
    expect(page).to have_text /\d{1,2}\/\d{1,2}\s\d{1,2}:\d{1,2}/
    expect(page).to have_content "未着手"
    expect(page).to have_content "低"
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
    .to change(Task, :count).by(1)
    }    
  end

  scenario "タスク詳細のテスト" do
    create_task(@user)
    visit root_path
    click_link "詳細"
    expect(page).to have_content "task name no.1"
    expect(page).to have_content "task content no.1"
    expect(page).to have_text /\d{1,2}\/\d{1,2}\s\d{1,2}:\d{1,2}/
    expect(page).to have_content "未着手"
    expect(page).to have_content 0
  end

  scenario "タスク並び替えのテスト" do
    task1 = create_task(@user)
    task2 = create_task(@user)
    task1.update(name:task1.name+"edit", content:"task content no.1 edit")
    visit root_path
    expect(page.body.index(task1.name)).to be < page.body.index(task2.name)
  end

  scenario "タスク終了期限による並び替えのテスト" do
    task_following = create_task(@user,expired_term:2)
    task_previous = create_task(@user,expired_term:1)

    visit root_path
    click_link "期限でソート"
    expect(page.body.index(task_previous.name)).to be < page.body.index(task_following.name)
  end

  scenario "タイトル検索をしたら件数が変わるテスト" do
    task1 = create_task(@user,name_keyword: "key")
    task2 = create_task(@user,name_keyword: "")
    visit root_path
    fill_in "task_name", with: "key"
    click_button "Search!"
    expect(page.body.index(task1.name)).to be > 0
    expect(page.body.index(task2.name)).to_not be > 0
  end
  
  scenario "statusで検索をしたら件数が変わるテスト" do
    task1 = create_task(@user,status: 0)
    task2 = create_task(@user,status: 1)
    visit root_path
    select '未着手', from: :task_status
    click_button "Search!"
    expect(page.body.index(task1.name)).to be > 0
    expect(page.body.index(task2.name)).to_not be > 0
  end

  scenario "なにも選択をせず検索をしても件数が変わらないテスト" do
    task1 = create_task(@user)
    task2 = create_task(@user)
    visit root_path
    click_button "Search!"
    expect(page.body.index(task1.name)).to be > 0
    expect(page.body.index(task2.name)).to be > 0
  end

  scenario "タスク優先度によるによる並び替えのテスト" do
    task_low_priority = create_task(@user,priority: 0)
    task_middle_priority = create_task(@user,priority: 1)
    task_high_priority = create_task(@user,priority: 2)
    visit root_path
    click_link "優先度でソート"
    expect(page.body.index(task_high_priority.name)).to be < page.body.index(task_middle_priority.name)
    expect(page.body.index(task_middle_priority.name)).to be < page.body.index(task_low_priority.name)
    expect(page.body.index(task_high_priority.name)).to be < page.body.index(task_low_priority.name)
  end
end