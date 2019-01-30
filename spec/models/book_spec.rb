require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'relationships' do
    it {should have_many :reviews}
    it {should have_many(:authors).through(:author_books)}
  end

  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :author_id}
    it {should validate_numericality_of :pags}
  end

end
