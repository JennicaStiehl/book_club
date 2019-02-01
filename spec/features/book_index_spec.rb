require 'rails_helper'

RSpec.describe 'when visitor visits book index page', type: :feature do
  before :each do
    @author_1 = Author.create(name: 'Mark Z. Danielewski')
    @author_2 = Author.create(name: 'Terry Pratchett')
    @author_3 = Author.create(name: 'Neil Gaiman')
    @author_4 = Author.create(name: 'J. K. Rowling')
    @book_1 = @author_1.books.create(title: 'House of Leaves', pages: 709, year: 2000)
    @book_2 = Book.create(title: 'Good Omens', pages: 288, year: 1990, authors: [@author_2, @author_3])
    @book_3 = @author_4.books.create(title: 'Harry Potter and the Sorcerer\'s Stone', pages: 309, year: 1998)
    @user_1 = User.create(name: 'User 1')
    @review_1 = Review.create(review_title: 'House of Leaves Review', text: 'It was good.', rating: 3, book: @book_1, user: @user_1)
    @user_2 = User.create(name: 'User 2')
    @review_2 = Review.create(review_title: 'House of Leaves Review 2', text: 'It was great.', rating: 5, book: @book_1, user: @user_2)
    @review_3 = Review.create(review_title: 'Good Omens Review', text: 'It was amazing.', rating: 5, book: @book_2, user: @user_2)
  end
  it 'can see all titles and attributes of each book in the database' do
    #User Story 6

    visit books_path

    within(class: "book-#{@book_1.id}") do
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content("Pages: #{@book_1.pages}")
      expect(page).to have_content("Publication Year: #{@book_1.year}")
      expect(page).to have_content("Author(s): #{@book_1.authors.first.name}")
    end
    within(class: "book-#{@book_2.id}") do
      expect(page).to have_content(@book_2.title)
      expect(page).to have_content("Pages: #{@book_2.pages}")
      expect(page).to have_content("Publication Year: #{@book_2.year}")
      expect(page).to have_content("Author(s): #{@book_2.authors.first.name}, #{@book_2.authors.second.name}")
    end
  end

  it 'can see average book rating and number of reviews' do
    #User Story 7

    visit books_path

    within(class: "book-#{@book_1.id}") do
      expect(page).to have_content('Average Score: 4')
      expect(page).to have_content('Number of Reviews: 2')
    end

    within(class: "book-#{@book_2.id}") do
      expect(page).to have_content('Average Score: 5')
      expect(page).to have_content('Number of Reviews: 1')
    end
  end

  it 'can sort the page by rating, pages, and reviews' do
    #User Story 8
    visit books_path

    click_link('Pages (Ascending)')
    expect(page.all('.book-title')[0]).to have_content('Good Omens')
    expect(page.all('.book-title')[1]).to have_content('Harry Potter and the Sorcerer\'s Stone')
    expect(page.all('.book-title')[2]).to have_content('House of Leaves')

    click_link('Pages (Descending)')
    expect(page.all('.book-title')[0]).to have_content('House of Leaves')
    expect(page.all('.book-title')[1]).to have_content('Harry Potter and the Sorcerer\'s Stone')
    expect(page.all('.book-title')[2]).to have_content('Good Omens')

    # Need to add default value to average rating
    # click_link('Rating (Ascending)')
    # expect(page.all('.book-title')[0]).to have_content('Harry Potter and the Sorcerer\'s Stone')
    # expect(page.all('.book-title')[1]).to have_content('House of Leaves')
    # expect(page.all('.book-title')[2]).to have_content('Good Omens')
    #
    # click_link('Rating (Descending)')
    # expect(page.all('.book-title')[0]).to have_content('Good Omens')
    # expect(page.all('.book-title')[1]).to have_content('House of Leaves')
    # expect(page.all('.book-title')[2]).to have_content('Harry Potter and the Sorcerer\'s Stone')

    click_link('Reviews (Ascending)')
    expect(page.all('.book-title')[0]).to have_content('Harry Potter and the Sorcerer\'s Stone')
    expect(page.all('.book-title')[1]).to have_content('Good Omens')
    expect(page.all('.book-title')[2]).to have_content('House of Leaves')

    click_link('Reviews (Descending)')
    expect(page.all('.book-title')[0]).to have_content('House of Leaves')
    expect(page.all('.book-title')[1]).to have_content('Good Omens')
    expect(page.all('.book-title')[2]).to have_content('Harry Potter and the Sorcerer\'s Stone')
  end
end
