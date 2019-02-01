require 'rails_helper'

RSpec.describe 'when visitor visits a book\'s show page', type: :feature do
  before :each do
    @author_1 = Author.create(name: 'Terry Pratchett')
    @author_2 = Author.create(name: 'Neil Gaiman')
    @book_1 = Book.create(title: 'Good Omens', pages: 288, year: 1990, authors: [@author_1, @author_2])
    @user_1 = User.create(name: 'User 1')
    @review_1 = Review.create(review_title: 'House of Leaves Review', text: 'It was good.', rating: 3, book: @book_1, user: @user_1)
    @user_2 = User.create(name: 'User 2')
    @review_2 = Review.create(review_title: 'House of Leaves Review 2', text: 'It was great.', rating: 5, book: @book_1, user: @user_2)
  end
  it 'can see the book title, author(s), number of pages, and a list of reviews' do
    #User Story 10
    visit book_path(@book_1.id)
    within(class: 'book-info') do
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content("Author(s): #{@book_1.authors.first.name}")
      expect(page).to have_content("Pages: #{@book_1.pages}")
    end
    within(class: "review-#{@review_1.id}") do
      expect(page).to have_content('House of Leaves Review')
      expect(page).to have_content('It was good')
      expect(page).to have_content("Rating: #{@review_1.rating} / 5")
    end
    within(class: "review-#{@review_2.id}") do
      expect(page).to have_content('House of Leaves Review 2')
      expect(page).to have_content('It was great.')
      expect(page).to have_content("Rating: #{@review_2.rating} / 5")
    end
  end
end
