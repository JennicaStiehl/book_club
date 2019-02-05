require 'rails_helper'

RSpec.describe 'when visitor visits reviews new page', type: :feature do
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
  describe 'On this new page, I see a form where I can enter review info' do
    it 'sees a review title' do
      visit new_book_review_path(@book_1.id)

      fill_in 'review_review_title', with: 'I love Rails!'
      fill_in 'review_user', with: 'benfolds5'
      fill_in 'review_rating', with: 5
      fill_in 'review_text', with: 'really great stuff!'
      click_on 'Submit'
      expect(page).to have_current_path(book_path(@book_1))
      expect(page).to have_content('I love Rails!')
    end





  end
end
