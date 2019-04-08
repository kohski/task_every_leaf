class User < ApplicationRecord
  before_create :first_user_is_admin
  before_update :exist_at_least_one_admin
  attr_accessor :is_abort_by_admin
  attr_accessor :commit_action

  validates :name, presence: true, length:{maximum:255}
  validates :email,presence: true, length:{maximum: 255},
            format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: true
  has_secure_password
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy
  validates :password, presence: true, length:{ minimum:6 }, on: :create

  private

  def exist_at_least_one_admin
    if User.all.pluck(:is_admin).count(true) == 1
      self.is_admin = true
      if self.commit_action == "解除"
        self.is_abort_by_admin = true
      end
    end
  end

  def first_user_is_admin
    if User.count == 0
      self.is_admin = true
    end
  end
end