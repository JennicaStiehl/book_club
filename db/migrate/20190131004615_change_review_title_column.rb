class ChangeReviewTitleColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column(:reviews, :title, :review_title)
  end
end
