require 'rails_helper'

RSpec.describe 'Todos index page', js: true do
  before do
    Todo.create!(name: 'Eat breakfast')
    Todo.create!(name: 'Sleep')
    visit todos_path
  end

  it 'should display the page header' do
    expect(page).to have_content 'Todos'
  end

  it 'shows the name of our todos' do
    expect(page).to have_content 'Eat breakfast'
    expect(page).to have_content 'Sleep'
  end
end
