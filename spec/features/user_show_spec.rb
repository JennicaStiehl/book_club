require 'rails_helper'

RSpec.describe 'when visitor visits a user\'s show page', type: :feature do
  before :each do
    @author_1 = Author.create(name: 'Mark Z. Danielewski')
    @book_1 = Book.create(title: 'House of Leaves', pages: 709, year: 2000, authors: [@author_1])
    @user_1 = User.create(name: 'User 1')
    @review_1 = Review.create(review_title: 'House of Leaves Review 1', text: 'I hated it.', rating: 1, book: @book_1, user: @user_1)
    @review_2 = Review.create(review_title: 'House of Leaves Review 2', text: 'I didn\'t like it.', rating: 2, book: @book_1, user: @user_1)
    @review_3 = Review.create(review_title: 'House of Leaves Review 3', text: 'I liked it', rating: 3, book: @book_1, user: @user_1)
  end

  it 'displays all reviews by that user, each with a title, rating and text' do
    # User Story 16

    visit user_path(@user_1.id)

    within(id: "user-review-#{@review_1.id}") do
      expect(page).to have_content("#{@review_1.review_title}")
      expect(page).to have_content("Rating: #{@review_1.rating} / 5")
      expect(page).to have_content("#{@review_1.text}")
    end
  end

  it 'has options to sort the page\'s reviews by age' do
    # User Story 17

    visit user_path(@user_1.id)

    click_link('Oldest')

    expect(page.all('.title')[0]).to have_content("#{@review_3.review_title}")
    expect(page.all('.title')[1]).to have_content("#{@review_2.review_title}")
    expect(page.all('.title')[2]).to have_content("#{@review_1.review_title}")

    click_link('Newest')

    expect(page.all('.title')[0]).to have_content("#{@review_1.review_title}")
    expect(page.all('.title')[1]).to have_content("#{@review_2.review_title}")
    expect(page.all('.title')[2]).to have_content("#{@review_3.review_title}")
  end

  it 'has an option to delete each review' do
    # User Story 18

    visit user_path(@user_1.id)

    expect(page).to have_content("#{@review_1.review_title}")
    within(id: "user-review-#{@review_1.id}") do
      click_link('Delete Review')
    end

    expect(page).to_not have_content("#{@review_1.review_title}")
  end
end
