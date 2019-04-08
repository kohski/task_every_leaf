class Label < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labeled_task, through: :labelings, source: :task
end
