class Task < ApplicationRecord
  validates :name, presence: true

  enum status: %i( waiting doing done )

  def self.sort(option)
    case option
    when 'new_create_date'
      all.order(created_at: :DESC)
    when 'old_limit_date'
      all.order(limit: :ASC)
    end
  end

  def self.filter(option)
    case option
    when 'waiting'
      Task.where(status: 0)
    when 'doing'
      Task.where(status: 1)
    when 'done'
      Task.where(status: 2)
    end
  end

  def self.search(keyword)
    Task.where("name LIKE ?", "%#{keyword}%")
      .or(where("description LIKE ?", "%#{keyword}%"))
  end
end
