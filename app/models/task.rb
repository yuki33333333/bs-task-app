class Task < ApplicationRecord
  validates :name, presence: true

  enum status: [ :wating, :doing, :done ]

  def self.sort(selection)
    case selection
    when 'new_create_date'
      all.order(created_at: :DESC)
    when 'old_limit_date'
      all.order(limit: :ASC)
    end
  end
end
