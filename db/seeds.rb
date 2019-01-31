# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require './app/models/author'
require './app/models/book'
Book.destroy_all
Author.destroy_all

authors = [
  { name: 'Mark Z. Danielewski' },
  { name: 'Terry Pratchett' },
  { name: 'Neil Gaiman' },
  { name: 'J. K. Rowling' },
  { name: 'William Shakespeare' },
  { name: 'Jane Austen' },
  { name: 'Mark Twain' },
  { name: 'James Patterson' },
  { name: 'Candice Fox' },
  { name: 'Maxine Paetro' }
]

authors.each do |author|
  Author.create(author)
end

Author.find_by(name: 'Mark Z. Danielewski').books.create(title: 'House of Leaves', pages: 709, year: 2000)
Book.create(title: 'Good Omens', pages: 288, year: 1990, authors: [Author.find_by(name: 'Terry Pratchett'), Author.find_by(name: 'Neil Gaiman')])
Author.find_by(name: 'J. K. Rowling').books.create(title: 'Harry Potter and the Sorcerer\'s Stone', pages: 309, year: 1998)

User.create(name: 'User 1')
User.create(name: 'User 2')

Review.create(review_title: 'House of Leaves Review', text: 'It was good.', rating: 3, book: Book.find_by(title: 'House of Leaves'), user: User.find_by(name: 'User 1'))
Review.create(review_title: 'House of Leaves Review 2', text: 'It was great.', rating: 5, book: Book.find_by(title: 'House of Leaves'), user: User.find_by(name: 'User 1'))
Review.create(review_title: 'Good Omens Review', text: 'It was amazing.', rating: 5, book: Book.find_by(title: 'Good Omens'), user: 'User 2')
