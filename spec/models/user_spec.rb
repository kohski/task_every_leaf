require 'rails_helper'

RSpec.describe User, type: :model do
  context "validationのテスト" do

    it "is invalid without name" do
      user = FactoryBot.build(:user,:without_name)
      user.valid?
      expect(user.errors[:name][0]).to include("を入力してください")
    end

    it "is invalid with over 255 character name" do
      user = FactoryBot.build(:user,:over_length_name)
      user.valid?
      expect(user.errors[:name][0]).to include("255文字以内で入力してください")
    end

    it "is invalid without email" do
      user = FactoryBot.build(:user,:without_email)
      user.valid?
      expect(user.errors[:email][0]).to include("を入力してください")
    end

    it "is invalid with over 255 character email" do
      user = FactoryBot.build(:user,:over_length_email)
      user.valid?
      expect(user.errors[:email][0]).to include("255文字以内で入力してください")
    end

    it "is invalid without email" do
      user = FactoryBot.build(:user,:without_email)
      user.valid?
      expect(user.errors[:email][0]).to include("を入力してください")
    end

    it "is invalid with not formated email" do
      user = FactoryBot.build(:user,:not_formatted_email)
      user.valid?
      expect(user.errors[:email][0]).to include("は不正な値です")
    end

    it "is invalid with  duplicate email" do
      user_previous = FactoryBot.create(:user,:duplicate_email_1)
      user_following = FactoryBot.build(:user,:duplicate_email_2)
      user_following.valid?
      expect(user_following.errors[:email][0]).to include("はすでに存在します")
    end

    it "is invalid with short password" do
      user = FactoryBot.build(:user,:with_short_password)
      user.valid?
      puts user.errors[:password][0]
      expect(user.errors[:password][0]).to include("は6文字以上で入力してください")
    end

  end
end
