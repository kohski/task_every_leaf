class Label < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labeled_task, through: :labelings, source: :task
  validates :name, uniqueness: {scope: :user_id}, presence: true, length:{ maximum: 255}

end
