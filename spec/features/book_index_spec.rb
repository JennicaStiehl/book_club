require 'rails_helper'

RSpec.describe 'when visitor visits book index page', type: :feature do
  it 'can see all titles and attributes of each book in the database' do
    #User Story 6
    author_1 = Author.create(name: 'Mark Z. Danielewski')
    author_2 = Author.create(name: 'Terry Pratchett')
    author_3 = Author.create(name: 'Neil Gaiman')
    book_1 = author_1.books.create(title: 'House of Leaves', pages: 709, year: 2000)
    book_2 = Book.create(title: 'Good Omens', pages: 288, year: 1990, authors: [author_2, author_3])

    visit '/books'
    save_and_open_page
    within "#book-#{book_1.id}" do
      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_1.pages)
      expect(page).to have_content(book_1.year)
      expect(page).to have_content(book_1.authors.name)
      expect(page).to_not have_content(book_2.title)
    end

    within "#book-#{book_2.id}" do
      expect(page).to have_content(book_2.title)
      expect(page).to have_content(book_2.pages)
      expect(page).to have_content(book_2.year)
      expect(page).to have_content(book_2.authors.name)
      expect(page).to_not have_content(book_1.title)
    end
  end
end
