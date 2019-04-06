class Task < ApplicationRecord

  # scope :search_both, -> (name, status){where('name LIKE ? ',"%#{name}%").where(status: status)}
  # scope :search_name, ->(name){ where('name LIKE ?',"%#{name}%") }
  # scope :search_status, -> (status){ where(status: status) }

  scope :search, -> (name,status){
    status = "" if status.to_i > 2
    if name != "" && status !=""
      where('name LIKE ? ',"%#{name}%").where(status: status)
    elsif name != "" && status ==""
      where('name LIKE ?',"%#{name}%")
    elsif name == "" && status != ""
      where(status: status)
    else
      all
    end
  }

  validates :name, presence: true, length:{ in: 1..255  }
  validates :content, length:{ maximum: 1000  }
  validates :status, numericality: { only_integer: true , greater_than_or_equal_to: 0,less_than_or_equal_to:2 }

  enum priority:{'高': 2,'中': 1,'低': 0}

  belongs_to :user
end
