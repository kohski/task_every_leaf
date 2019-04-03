require 'rails_helper'

RSpec.describe Task, type: :model do
  context "validation test" do
    it "is invalid without name" do
      task = FactoryBot.build(:task, :no_name)
      task.valid?
      expect(task.errors[:name][0]).to include("can't be blank")
    end

    it "is invalid with name over 255charactors" do
      task = FactoryBot.build(:task, :over_255_charactors_name)
      task.valid?
      expect(task.errors[:name][0]).to include("is too long ")
    end

    it "is invalid with content over 1,000 charactors" do
      task = FactoryBot.build(:task, :over_1000_charactors_content)
      task.valid?
      expect(task.errors[:content][0]).to include("is too long ")
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
    before do
      FactoryBot.create(:task_sort,:name_a_status_0)
      FactoryBot.create(:task_sort,:name_a_status_1)
      FactoryBot.create(:task_sort,:name_a_status_2)
      FactoryBot.create(:task_sort,:name_b_status_0)
      FactoryBot.create(:task_sort,:name_b_status_1)
      FactoryBot.create(:task_sort,:name_b_status_2)
      @tasks = Task.all
    end

    context "statusが未選択の場合" do
      it "nameが空欄で検索された場合全て表示される" do
        sorted_task = subject { Task.search('', 4 ) }
        expect(sorted_task).to include
      end

      it "nameの検索条件に合致するtaskがある場合nameのみで検索される" do
      end

      it "nameの検索条件に合致するtaskがない場合、何も表示されない" do
      end

    end

    context "statusが選択されている場合" do
      it "nameが空欄の場合、statusのみで検索される" do
      end

      it "nameの検索条件に合致するtaskがある場合、nameとtaskで検索される" do
      end

      it "nameの検索条件に合致するtaskがない場合、statusのみで検索される" do
      end

    end

  end

end
