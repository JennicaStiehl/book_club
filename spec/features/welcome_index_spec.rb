require "rails_helper"

RSpec.describe 'when a visitor visits the welcome page it' do
  it 'welcomes the visitor and lists the app\'s creators' do
    visit root_path

    expect(page).to have_content('Welcome to Book Club!')
    expect(page).to have_content('Developed by: Chris Lewis and Jennica Stiehl')
  end
  it 'displays a link to the book index page' do
    visit root_path

    click_link('Click to Enter')

    expect(current_path).to eq(books_path)
  end

  it 'contains links to the project GitHub page, Waffle page, and each group member\'s personal GitHub' do
    visit root_path

    expect(page).to have_selector "a[href='https://github.com/JennicaStiehl']", text: "Jennica's GitHub"
    expect(page).to have_selector "a[href='https://github.com/csvlewis']", text: "Chris's GitHub"
    expect(page).to have_selector "a[href='https://github.com/JennicaStiehl/book_club']", text: "GitHub Project Page"
    expect(page).to have_selector "a[href='https://waffle.io/JennicaStiehl/book_club']", text: "Waffle Project Page"
  end
end
