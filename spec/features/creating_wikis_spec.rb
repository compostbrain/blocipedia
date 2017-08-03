require 'rails_helper'
RSpec.feature "Creating Wikis" do
  before do
    @user = User.create!(email: "user@example.com", password: "very-secret")
    login_as(@user)

  end
  scenario 'A user creates a new wiki' do

    visit "wikis/index"
    click_button 'New Wiki'
    fill_in 'Title', with: 'Creating a wiki'
    fill_in 'Body', with: 'Lorem Ipsum'
    click_button 'Save'
    expect(page).to have_content('Wiki has been created')
    expect(page.current_path).to eq(wikis_path)
  end
end
