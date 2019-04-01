class Task < ApplicationRecord
  validates :name, presence: true, length:{ in: 1..255  }
  validates :content, length:{ maximum: 1000  }
end
