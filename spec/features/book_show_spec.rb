require 'rails_helper'

RSpec.describe 'when visitor visits a book\'s show page', type: :feature do
  before :each do
    @author_1 = Author.create(name: 'Mark Z. Danielewski')
    @book_1 = Book.create(title: 'House of Leaves', pages: 709, year: 2000, authors: [@author_1])
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
  it 'shows the book title, author(s), number of pages, and a list of reviews' do
    # User Story 10
    visit book_path(@book_1.id)

    within(id: 'book-info') do
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content("Author(s): #{@book_1.authors.first.name}")
      expect(page).to have_content("Pages: #{@book_1.pages}")
    end
    within(id: "book-review-#{@review_1.id}") do
      expect(page).to have_content("#{@review_1.review_title}")
      expect(page).to have_content("#{@review_1.user.name}")
      expect(page).to have_content("Rating: #{@review_1.rating} / 5")
    end
    within(id: "book-review-#{@review_2.id}") do
      expect(page).to have_content("#{@review_2.review_title}")
      expect(page).to have_content("#{@review_2.user.name}")
      expect(page).to have_content("Rating: #{@review_2.rating} / 5")
    end
  end
  it 'shows the top and bottom three reviews for the book as well as the average rating of all reviews' do
    # User Story 11
    visit book_path(@book_1.id)

    within(id: 'top-reviews') do
      expect(page).to have_content("Title: #{@review_5.review_title}")
      expect(page).to have_content("Rating: #{@review_5.rating} / 5")
      expect(page).to have_content("#{@review_5.user.name}")

      expect(page).to have_content("Title: #{@review_4.review_title}")
      expect(page).to have_content("Rating: #{@review_4.rating} / 5")
      expect(page).to have_content("#{@review_4.user.name}")

      expect(page).to have_content("Title: #{@review_3.review_title}")
      expect(page).to have_content("Rating: #{@review_3.rating} / 5")
      expect(page).to have_content("#{@review_3.user.name}")
    end
    within(id: 'bottom-reviews') do
      expect(page).to have_content("Title: #{@review_1.review_title}")
      expect(page).to have_content("Rating: #{@review_1.rating} / 5")
      expect(page).to have_content("#{@review_1.user.name}")

      expect(page).to have_content("Title: #{@review_2.review_title}")
      expect(page).to have_content("Rating: #{@review_2.rating} / 5")
      expect(page).to have_content("#{@review_2.user.name}")

      expect(page).to have_content("Title: #{@review_3.review_title}")
      expect(page).to have_content("Rating: #{@review_3.rating} / 5")
      expect(page).to have_content("#{@review_3.user.name}")
    end
    within(id: 'book-info') do
      expect(page).to have_content('Average Rating: 3.0')
    end
  end

  it 'has an option to delete the book' do
    # User Story 19
    visit book_path(@book_1.id)
    click_link('Delete This Book')

    expect(current_path).to eq(books_path)
    expect(page).to_not have_content("#{@book_1.title}")
  end

  it 'has an option to add a review' do
    visit book_path(@book_1.id)
    click_link('Add Review')

    expect(current_path).to eq(new_book_review_path(@book_1.id))
    expect(page).to have_content('Add Review')
  end


end
