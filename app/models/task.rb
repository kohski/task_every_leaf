class Task < ApplicationRecord
  validates :name, presence: true, length:{ in: 1..255  }
  validates :content, length:{ maximum: 1000  }
  validates :status, numericality: { only_integer: true , greater_than_or_equal_to: 0,less_than_or_equal_to:2 }
end
