require 'rails_helper'

RSpec.describe Book, type: :model do
  before :each do
    @author_1 = Author.create(name: "Gloria Stiehl")
    @book_1 = Book.create(title: "new book", pages:20, year: 2019, authors: [@author_1])
    @user_1 = User.create(name: "Joe")
    @user_3 = User.create(name: "Josh")
    @user_2 = User.create(name: "Jane")
    @review_1 = @book_1.reviews.create(review_title: "terrible", rating: 3, text: "terrible and boring, too long.", user: @user_1)
    @review_2 = @book_1.reviews.create(review_title: "LOL", rating: 5, text: "very fun; lots of laughs", user: @user_2)
    @review_3 = @book_1.reviews.create(review_title: "stuff", rating: 4, text: "all the stuff", user: @user_3)

    @author_2 = Author.create(name: "Gloria Estonia")
    @book_2 = Book.create(title: "The only book you need", pages:20, year: 2019, authors: [@author_2])
    @review_4 = @book_2.reviews.create(review_title: "ok", rating: 5, text: "not my thing", user: @user_2)
    @review_5 = @book_2.reviews.create(review_title: "fun", rating: 5, text: "good times, good read", user: @user_1)
    @review_6 = @book_2.reviews.create(review_title: "interesting", rating: 5, text: "when does the second book come out???", user: @user_1)

    @author_3 = Author.create(name: "John Stone")
    @book_3 = Book.create(title: "Intergalactic Voyage", pages:20, year: 2019, authors: [@author_3])
    @review_7 = @book_3.reviews.create(review_title: "my review", rating: 1, text: "text", user: @user_1)
    @review_8 = @book_3.reviews.create(review_title: "meh", rating: 3, text: "some text", user: @user_1)
    @review_9 = @book_3.reviews.create(review_title: "leaves something to be desired", rating: 2, text: "more text and stuff", user: @user_1)

    @author_4 = Author.create(name: "John Stone")
    @book_4 = Book.create(title: "The first Voyage", pages:20, year: 2019, authors: [@author_3])
    @review_10 = @book_4.reviews.create(review_title: "a", rating: 1, text: "a", user: @user_1)
    @review_11 = @book_4.reviews.create(review_title: "b", rating: 1, text: "b", user: @user_1)
    @review_12 = @book_4.reviews.create(review_title: "c", rating: 1, text: "c", user: @user_1)
  end
  describe 'relationships' do
    it {should have_many :reviews}
    it {should have_many(:authors).through(:author_books)}
    it {should have_many :author_books}
  end

  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :pages}
    it {should validate_presence_of :year}
    it {should validate_uniqueness_of :title}
  end

  describe 'class methods' do
    describe '.top_by_rating' do
      it 'returns the top three books by review rating' do
        expect(Book.top_by_rating).to eq([@book_2, @book_1, @book_3])
      end
    end

    describe '.bottom_by_rating' do
      it 'returns the bottom three books by review rating' do
        expect(Book.bottom_by_rating).to eq([@book_4, @book_3, @book_1])
      end
    end
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

    describe '.top_review' do
      it 'returns the top review by rating for a given book' do
        expect(@book_1.top_review).to eq(@review_5)
      end
    end
  end
end
