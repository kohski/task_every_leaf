require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  scenario "タスク一覧のテスト" do
    FactoryBot.create(:task)
    
    visit root_path
    expect(page).to have_content "test task"
    expect(page).to have_content "test task content"
  end

  # scenario "タスク作成のテスト" do
  #   visit root_path
  #   click_link "新しいタスク"
  #   expect {
  #     fill_in "task_name", with: "test name"
  #     fill_in "task_content", with: "test content" 
  #     click_button "登録"
  #     expect(page).to have_content "test name"
  #     expect(page).to have_content "test content"
  #   .to change(Task, :count).by(1)
  #   }    
  # end

  # scenario "タスク詳細のテスト" do
  #   FactoryBot.create(:task)
  #   visit root_path
  #   click_link "詳細"
  #   expect(page).to have_content "test task"
  #   expect(page).to have_content "test task content" 
  # end

  # scenario "タスク並び替えのテスト" do
  #   task1 = FactoryBot.create(:task,:sequence)
  #   task2 = FactoryBot.create(:task,:sequence)
  #   task1.update(name:"test task name no.1 edit", content:"test task content no.1 edit")
  #   visit root_path
  #   expect(page.body.index(task1.name)).to be < page.body.index(task2.name)
  # end

  # scenario "タスク終了期限による並び替えのテスト" do
  #   task_following = FactoryBot.create(:task, :sort_by_expired_at_following)
  #   task_previous = FactoryBot.create(:task, :sort_by_expired_at_previous)
  #   visit root_path
  #   click_link "期限でソート"
  #   expect(page.body.index(task_previous.name)).to be < page.body.index(task_following.name)
  # end

  # scenario "タイトル検索をしたら件数が変わるテスト" do
  #   create_data_for_search_test
  #   visit root_path
  #   fill_in "task_name", with: "b_name"
  #   click_button "Search!"
  #   expect(page.body.index('b_name_1')).to be > 0
  #   expect(page.body.index('b_name_2')).to be > 0
  #   expect(page.body.index('b_name_3')).to be > 0
  # end
  
  # scenario "statusで検索をしたら件数が変わるテスト" do
  #   create_data_for_search_test
  #   visit root_path
  #   select '未着手', from: :task_status
  #   click_button "Search!"
  #   expect(page.body.index('a_name_1')).to be > 0
  #   expect(page.body.index('b_name_1')).to be > 0
  # end

  # scenario "なにも選択をせず検索をしても件数が変わらないテスト" do
  #   create_data_for_search_test
  #   visit root_path
  #   click_button "Search!"
  #   expect(page.body.index('a_name_1')).to be > 0
  #   expect(page.body.index('a_name_2')).to be > 0
  #   expect(page.body.index('a_name_3')).to be > 0
  #   expect(page.body.index('b_name_1')).to be > 0
  #   expect(page.body.index('b_name_2')).to be > 0
  #   expect(page.body.index('b_name_3')).to be > 0
  # end

  # scenario "タスク優先度によるによる並び替えのテスト" do
  #   task_low_priority = FactoryBot.create(:task, :low_priority)
  #   task_middle_priority = FactoryBot.create(:task, :middle_priority)
  #   task_high_priority = FactoryBot.create(:task, :high_priority)
  #   visit root_path
  #   click_link "優先度でソート"
  #   expect(page.body.index(task_high_priority.name)).to be < page.body.index(task_middle_priority.name)
  #   expect(page.body.index(task_middle_priority.name)).to be < page.body.index(task_low_priority.name)
  #   expect(page.body.index(task_high_priority.name)).to be < page.body.index(task_low_priority.name)
  # end

end