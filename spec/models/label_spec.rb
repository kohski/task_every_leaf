require 'rails_helper'

RSpec.describe Label, type: :model do
  context "validation test" do
    it "is invalid without name" do
      label = FactoryBot.build(:label,:without_name)
      label.invalid?
      expect(label.errors[:name][0]).to include("を入力してください")
    end

    it "is invalid with over 255 characters name" do
      label = FactoryBot.build(:label,:with_over_255_name)
      label.invalid?
      puts label.errors[:name][0]
      expect(label.errors[:name][0]).to include("は255文字以内で入力してください")
    end

    it "is invalid with duplicate name" do
      user = FactoryBot.create(:user)
      label1 = create_label(user)
      label2 = build_label(user)
      label2.valid?
      expect(label2.errors[:name][0]).to include("はすでに存在します")
    end

  end
end
