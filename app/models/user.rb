class User < ApplicationRecord
  has_many :reviews

  def sort_by_newest
    Reviews.order(created_at: :desc)
  end

  def sort_by_oldest
    Reviews.order(created_at: :asc)
  end
end
