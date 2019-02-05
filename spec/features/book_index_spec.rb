require 'rails_helper'

RSpec.describe 'when visitor visits book index page it', type: :feature do
  before :each do
    @author_1 = Author.create(name: "Gloria Stiehl")
    @book_1 = Book.create(title: "new book", pages:10, year: 2019, authors: [@author_1])
    @user_1 = User.create(name: "Joe")
    @user_3 = User.create(name: "Josh")
    @user_2 = User.create(name: "Jane")
    @review_1 = @book_1.reviews.create(review_title: "LOL", rating: 5, text: "very fun; lots of laughs", user: @user_2)
    @review_2 = @book_1.reviews.create(review_title: "stuff", rating: 4, text: "all the stuff", user: @user_3)

    @author_2 = Author.create(name: "Gloria Estonia")
    @book_2 = Book.create(title: "The only book you need", pages:20, year: 2019, authors: [@author_1, @author_2])
    @review_3 = @book_2.reviews.create(review_title: "ok", rating: 5, text: "not my thing", user: @user_2)
    @review_4 = @book_2.reviews.create(review_title: "fun", rating: 5, text: "good times, good read", user: @user_1)
    @review_5 = @book_2.reviews.create(review_title: "interesting", rating: 5, text: "when does the second book come out???", user: @user_1)

    @author_3 = Author.create(name: "John Stone")
    @book_3 = Book.create(title: "Intergalactic Voyage", pages:30, year: 2019, authors: [@author_3])
    @review_6 = @book_3.reviews.create(review_title: "terrible", rating: 3, text: "terrible and boring, too long.", user: @user_1)
    @review_7 = @book_3.reviews.create(review_title: "my review", rating: 1, text: "text", user: @user_1)
    @review_8 = @book_3.reviews.create(review_title: "meh", rating: 3, text: "some text", user: @user_1)
    @review_9 = @book_3.reviews.create(review_title: "leaves something to be desired", rating: 2, text: "more text and stuff", user: @user_1)
    @review_10 = @book_3.reviews.create(review_title: "a", rating: 1, text: "a", user: @user_1)

    @author_4 = Author.create(name: "John Stone")
    @book_4 = Book.create(title: "The first Voyage", pages:40, year: 2019, authors: [@author_3])
    @review_11 = @book_4.reviews.create(review_title: "b", rating: 1, text: "b", user: @user_1)
  end
  it 'displays all titles and attributes of each book in the database' do
    #User Story 6

    visit books_path

    within(id: "book-#{@book_1.id}-info") do
      expect(page).to have_content("Pages: #{@book_1.pages}")
      expect(page).to have_content("Year of Publication: #{@book_1.year}")
      expect(page).to have_content("Author(s): #{@book_1.authors.first.name}")
    end
    within(id: "book-#{@book_2.id}-info") do
      expect(page).to have_content("Pages: #{@book_2.pages}")
      expect(page).to have_content("Year of Publication: #{@book_2.year}")
      expect(page).to have_content("Author(s): #{@book_2.authors.first.name} #{@book_2.authors.second.name}")
    end
  end

  it 'displays average book rating and number of reviews' do
    #User Story 7

    visit books_path

    within(id: "book-#{@book_1.id}-stats") do
      expect(page).to have_content("Average Rating: #{@book_1.average_rating} / 5.0")
      expect(page).to have_content("Total Reviews: #{@book_1.reviews.count}")
    end

    within(id: "book-#{@book_2.id}-stats") do
      expect(page).to have_content("Average Rating: #{@book_2.average_rating} / 5.0")
      expect(page).to have_content("Total Reviews: #{@book_2.reviews.count}")
    end
  end

  it 'can sort the page by rating, pages, and reviews' do
    #User Story 8

    visit books_path

    click_link('Pages (Ascending)')

    expect(page.all('.book-title-image')[0]).to have_content("#{@book_1.title}")
    expect(page.all('.book-title-image')[1]).to have_content("#{@book_2.title}")
    expect(page.all('.book-title-image')[2]).to have_content("#{@book_3.title}")

    click_link('Pages (Descending)')
    expect(page.all('.book-title-image')[0]).to have_content("#{@book_4.title}")
    expect(page.all('.book-title-image')[1]).to have_content("#{@book_3.title}")
    expect(page.all('.book-title-image')[2]).to have_content("#{@book_2.title}")

    click_link('Rating (Ascending)')
    expect(page.all('.book-title-image')[0]).to have_content("#{@book_4.title}")
    expect(page.all('.book-title-image')[1]).to have_content("#{@book_3.title}")
    expect(page.all('.book-title-image')[2]).to have_content("#{@book_1.title}")

    click_link('Rating (Descending)')
    expect(page.all('.book-title-image')[0]).to have_content("#{@book_2.title}")
    expect(page.all('.book-title-image')[1]).to have_content("#{@book_1.title}")
    expect(page.all('.book-title-image')[2]).to have_content("#{@book_3.title}")

    click_link('Reviews (Ascending)')
    expect(page.all('.book-title-image')[0]).to have_content("#{@book_4.title}")
    expect(page.all('.book-title-image')[1]).to have_content("#{@book_1.title}")
    expect(page.all('.book-title-image')[2]).to have_content("#{@book_2.title}")

    click_link('Reviews (Descending)')
    expect(page.all('.book-title-image')[0]).to have_content("#{@book_3.title}")
    expect(page.all('.book-title-image')[1]).to have_content("#{@book_2.title}")
    expect(page.all('.book-title-image')[2]).to have_content("#{@book_1.title}")
  end

  it 'displays a navigation bar' do
    # User Story 2
    visit books_path

    expect(page).to have_content('Home')
    expect(page).to have_content('Books')
  end

  describe "displays an area with statistics about all books" do

    it "with three of the highest-rated books (book title and rating score)" do
      visit books_path

      within(id: 'top-book-stats') do
        expect(page).to have_content(@book_2.title, "Rating: #{@book_2.average_rating} / 5")
        expect(page).to have_content(@book_1.title, "Rating: #{@book_1.average_rating} / 5")
      end
    end
    it "with three of the worst-rated books (book title and rating score)" do
      visit books_path

      within(id: 'bottom-book-stats') do
        expect(page).to have_content(@book_4.title, "Rating: #{@book_4.average_rating} / 5")
        expect(page).to have_content(@book_3.title, "Rating: #{@book_3.average_rating} / 5")
      end
    end
    it "with the three users who have written the most reviews (user name and review count)" do
      visit books_path

      within(id: "top-user-stats") do
        expect(page).to have_content(@user_1.name, "Total Reviews: #{@user_1.reviews.count}")
        expect(page).to have_content(@user_2.name, "Total Reviews: #{@user_2.reviews.count}")
      end
    end

  end
  it "has a link to create a new book" do
    visit books_path
    click_link('Add a Book')
    fill_in 'Title', with: 'my book'
    fill_in 'Authors', with: 'john smith, gloria stiehl'
    fill_in 'Pages', with: 150
    fill_in 'Year', with: 1990
    click_on 'Submit'

    expect(page).to have_current_path(books_path)
    expect(page).to have_content('My Book')
    expect(page).to have_content("Author(s): #{@author_1.name}, John Smith")
    expect(page).to have_content(150)
    expect(page).to have_content(1990)
  end
end
