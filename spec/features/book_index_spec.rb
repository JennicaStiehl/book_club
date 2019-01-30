require 'rails_helper'

RSpec.describe 'when visitor visits book index page', type: :feature do
  it 'can see all titles and attributes of each book in the database' do
    book_1 = Book.create(title: 'House of Leaves', pages: 709, year: 2000)
    author_1 = Author.create(name: 'Mark Z. Danielewski')
    AuthorBook.create(book_id: book_1.id, author_id: author_1.id)
  end
end
