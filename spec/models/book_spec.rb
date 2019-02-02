require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'relationships' do
    # it {should have_many :reviews}
    # it {should have_many(:authors).through(:author_books)}
  end

  describe 'validations' do
    # it {should validate_presence_of :title}
    # it {should validate_presence_of :author_id}
    # it {should validate_numericality_of :pags}
  end

  describe 'Instance Methods' do
    before :each do
      @author_1 = Author.create(name: 'Mark Z. Danielewski')
      @author_2 = Author.create(name: 'Terry Pratchett')
      @author_3 = Author.create(name: 'Neil Gaiman')
      @book_1 = @author_1.books.create(title: 'House of Leaves', pages: 709, year: 2000)
      @book_2 = Book.create(title: 'Good Omens', pages: 288, year: 1990, authors: [@author_2, @author_3])
      @user_1 = User.create(name: 'User 1')
      @user_2 = User.create(name: 'User 2')
      @user_3 = User.create(name: 'User 3')
      @user_4 = User.create(name: 'User 4')
      @user_5 = User.create(name: 'User 5')
      @review_1 = Review.create(review_title: 'House of Leaves Review', text: 'I hated it.', rating: 1, book: @book_1, user: @user_1)
      @review_2 = Review.create(review_title: 'House of Leaves Review 2', text: 'I didn\'t like it.', rating: 2, book: @book_1, user: @user_2)
      @review_3 = Review.create(review_title: 'House of Leaves Review 3', text: 'I liked it', rating: 3, book: @book_1, user: @user_3)
      @review_4 = Review.create(review_title: 'House of Leaves Review 4', text: 'It was great.', rating: 4, book: @book_1, user: @user_4)
      @review_5 = Review.create(review_title: 'House of Leaves Review 5', text: 'It was amazing!', rating: 5, book: @book_1, user: @user_5)
    end
    describe '.top_reviews' do
      it 'returns the top three reviews for that book' do
        expect(@book_1.top_reviews).to eq([@review_5, @review_4, @review_3])
      end
    end

    describe '.bottom_reviews' do
      it 'returns the bottom three reviews for that book' do
        expect(@book_1.bottom_reviews).to eq([@review_1, @review_2, @review_3])
      end
    end

    describe '.average_rating' do
      it 'returns the average rating for that book' do
        expect(@book_1.average_rating).to eq(3)
      end
    end

    describe '.coauthors(author)' do
      it 'returns an array of all authors for the book, excluding the author passed as an argument' do
        expect(@book_1.coauthors(@author_1)).to eq([])
        expect(@book_2.coauthors(@author_2)).to eq([@author_3])
      end
    end
  end
end
