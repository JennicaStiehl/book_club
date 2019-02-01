require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'relationships' do
    # it {should have_many :reviews}
    # it {should have_many(:authors).through(:author_books)}
  end

  describe 'validations' do
    it {should validate_presence_of :title}
    # it {should validate_presence_of :authors}
    # it {should validate_numericality_of :pages}
  end

  describe 'class methods' do
    it ".avg_rating" do
      #user story 9
      author_1 = Author.create(name: "Gloria Stiehl")
      book_1 = Book.create(title: "new book", pages:20, year: 2019, authors: [author_1])
      user_1 = User.create(name: "Joe")
      review_1 = book_1.reviews.create(review_title: "terrible", rating: 3, text: "terrible and boring, too long.", user: user_1)
      review_2 = book_1.reviews.create(review_title: "LOL", rating: 5, text: "very fun; lots of laughs", user: user_1)
      review_3 = book_1.reviews.create(review_title: "stuff", rating: 4, text: "all the stuff", user: user_1)

      expect(book_1.avg_rating(book_1.id)).to eq(4)
    end
  end

  # describe 'instance methods' do
  #   it "#rating" do
      # end
  #  end

end
