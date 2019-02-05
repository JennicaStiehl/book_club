require 'rails_helper'

RSpec.describe Review, type: :model do

  describe 'relationships' do
    it {should belong_to :book}
    it {should belong_to :user}
  end

  describe 'validations' do
    it {should validate_presence_of :review_title}
    it {should validate_presence_of :rating}
    it {should validate_presence_of :text}
  end
end
