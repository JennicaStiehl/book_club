require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'relationships' do
    it {should have_many :books.through(:author_books)}
    it {should have_many :author_books}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_uniqueness_of :name}
  end
end
