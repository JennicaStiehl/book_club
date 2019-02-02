require "rails_helper"

RSpec.describe 'when a visitor visits an author\'s show page' do
  before :each do
    @author_1 = Author.create(name: 'Terry Pratchett')
    @author_2 = Author.create(name: 'Neil Gaiman')
    @book_1 = Book.create(title: 'Good Omens', pages: 288, year: 1990, authors: [@author_1, @author_2])
    @book_2 = Book.create(title: 'Mort', pages: 304, year: 1987, authors: [@author_1])
    @book_3 = Book.create(title: 'The Colour of Magic', pages: 206, year: 1983, authors: [@author_1])
  end
  it 'displays all books by that author, each with a title, publication year, number of pages, and any additional authors' do
    visit author_path(@author_1.id)
    save_and_open_page
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
end
