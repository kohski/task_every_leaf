require 'rails_helper'

RSpec.describe Task, type: :model do
  context "validation test" do
    it "is invalid without name" do
      task = FactoryBot.build(:task, :no_name)
      task.valid?
      expect(task.errors[:name][0]).to include("入力してください")
    end

    it "is invalid with name over 255charactors" do
      task = FactoryBot.build(:task, :over_255_charactors_name)
      task.valid?
      expect(task.errors[:name][0]).to include("255文字以内で入力してください")
    end

    it "is invalid with content over 1,000 charactors" do
      task = FactoryBot.build(:task, :over_1000_charactors_content)
      task.valid?
      expect(task.errors[:content][0]).to include("1000文字以内で入力してください")
    end

    it "is valid with name(1..255charactors) and blank content" do
      task = FactoryBot.build(:task, :valid_name_with_no_content)
      task.valid?
      expect(task).to be_valid
    end

    it "is valid with name(1..255charactors) and content(1..1000charactors)" do
      task = FactoryBot.build(:task)
      task.valid?
      expect(task).to be_valid
    end
  end

  context "scope test" do
    let!(:task1){ create(:task_searched,:name_a_status_0) }
    let!(:task2){ create(:task_searched,:name_a_status_1) }
    let!(:task3){ create(:task_searched,:name_a_status_2) }
    let!(:task4){ create(:task_searched,:name_b_status_0) }
    let!(:task5){ create(:task_searched,:name_b_status_1) }
    let!(:task6){ create(:task_searched,:name_b_status_2) }

    context "statusが未選択の場合" do
      it "nameが空欄で検索された場合全て表示される" do
        searched_task = Task.search('', 4 )
        expect(searched_task).to match_array([
          task1,task2,task3,task4,task5,task6
        ])
      end

      it "nameの検索条件に合致するtaskがある場合nameのみで検索される" do
        searched_task = Task.search('b', 4 )
        expect(searched_task).to match_array([
          task4,task5,task6
        ])
      end

      it "nameの検索条件に合致するtaskがない場合、何も表示されない" do
        searched_task = Task.search('一致しない文字列', 4 )
        expect(searched_task).to match_array([])
      end

    end

    context "statusが選択されている場合" do

      it "nameが空欄の場合、statusのみで検索される" do
        searched_task = Task.search('', 0 )
        expect(searched_task).to match_array([
          task1,task4
        ])
      end

      it "nameの検索条件に合致するtaskがある場合、nameとtaskで検索される" do
        searched_task = Task.search('b', 0 )
        expect(searched_task).to match_array([
          task4
        ])
      end

      it "nameの検索条件に合致するtaskがない場合、statusのみで検索される" do
        searched_task = Task.search('一致しないタスク', 0 )
        expect(searched_task).to match_array([])
      end

    end

  end

end
