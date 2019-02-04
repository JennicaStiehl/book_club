require "rails_helper"

RSpec.describe 'when a visitor visits an author\'s show page it' do
  before :each do
    @author_1 = Author.create(name: 'Terry Pratchett')
    @author_2 = Author.create(name: 'Neil Gaiman')
    @book_1 = Book.create(title: 'Good Omens', pages: 288, year: 1990, authors: [@author_1, @author_2])
    @book_2 = Book.create(title: 'Mort', pages: 304, year: 1987, authors: [@author_1])
    @book_3 = Book.create(title: 'The Colour of Magic', pages: 206, year: 1983, authors: [@author_1])
    @user_1 = User.create(name: 'User 1')
    @user_2 = User.create(name: 'User 2')
    @review_1 = Review.create(review_title: 'Good Omens Review', text: 'It was great.', rating: 5, book: @book_1, user: @user_1)
    @review_2 = Review.create(review_title: 'Good Omens Review 2', text: 'I didn\'t like it.', rating: 1, book: @book_1, user: @user_2)
    @review_3 = Review.create(review_title: 'Mort Review', text: 'It was pretty bad.', rating: 2, book: @book_2, user: @user_1)
    @review_4 = Review.create(review_title: 'Mort Review 2', text: 'I liked it.', rating: 3, book: @book_2, user: @user_2)
    @review_5 = Review.create(review_title: 'The Colour of Magic Review', text: 'It was amazing.', rating: 5, book: @book_3, user: @user_1)
    @review_6 = Review.create(review_title: 'The Colour of Magic Review 2', text: 'It was awesome.', rating: 5, book: @book_3, user: @user_2)

  end

  it 'displays all books by that author, each with a title, publication year, number of pages, and any additional authors' do
    #User Story 14
    visit author_path(@author_1.id)

    within(class: "book-#{@book_1.id}") do
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content("Year of Publication: #{@book_1.year}")
      expect(page).to have_content("Pages: #{@book_1.pages}")
      expect(page).to have_content("Coauthor(s): #{@author_2.name}")
    end

    within(class: "book-#{@book_2.id}") do
      expect(page).to have_content(@book_2.title)
      expect(page).to have_content("Year of Publication: #{@book_2.year}")
      expect(page).to have_content("Pages: #{@book_2.pages}")
      expect(page).to have_content("Coauthor(s):")
    end

    within(class: "book-#{@book_3.id}") do
      expect(page).to have_content(@book_3.title)
      expect(page).to have_content("Year of Publication: #{@book_3.year}")
      expect(page).to have_content("Pages: #{@book_3.pages}")
      expect(page).to have_content("Coauthor(s):")
    end
  end

  it 'displays one of the top reviews for each book (review title, score, and username)' do
    #User Story 15
    visit author_path(@author_1.id)

    within(class: "book-#{@book_1.id}") do
      expect(page).to have_content("Review Title: #{@review_1.review_title}")
      expect(page).to have_content("Rating: #{@review_1.rating} / 5")
      expect(page).to have_content("Username: #{@review_1.user.name}")
    end

    within(class: "book-#{@book_2.id}") do
      expect(page).to have_content("Review Title: #{@review_4.review_title}")
      expect(page).to have_content("Rating: #{@review_4.rating} / 5")
      expect(page).to have_content("Username: #{@review_4.user.name}")
    end

    within(class: "book-#{@book_3.id}") do
      expect(page).to have_content("Review Title: #{@review_5.review_title}")
      expect(page).to have_content("Rating: #{@review_5.rating} / 5")
      expect(page).to have_content("Username: #{@review_5.user.name}")
    end
  end

  it 'has an option to delete the author' do
    #User Story 20
    visit author_path(@author_1.id)

    click_link('Delete Author')

    expect(current_path).to eq(books_path)
    expect(page).to_not have_content("#{@author_1.name}")
  end
end
