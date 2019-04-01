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
end
