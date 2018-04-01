require 'rails_helper'

context 'As a user, I can visit the root page' do
  describe 'and log in' do
    before(:all) do
      create(:user)
    end

    it "and successfully logs in to dashboard" do
      visit "/"

      fill_in "name", with: "Sam"
      fill_in "password", with: "test1"
      click_on "Sign in"

      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("Welcome Sam. Prepare for battle...ship.")
    end

    it "stays on login page with incorrect credentials" do
      visit root_path

      fill_in "name", with: "Sam"
      fill_in "password", with: "wrong"
      click_on "Sign in"

      expect(page).to have_content("Incorrect credentials")
    end
  end

  context 'as a logged in user' do
    describe 'I can log out' do
      it 'returns to the root page and I am no longer logged in' do
        user = create(:player)
        visit root_path

        fill_in "Name", with: user.name
        fill_in "password", with: user.password
        click_button 'Sign in'

        expect(page).to have_content "Logged in as #{user.name}"

        within('.nav-right') do
          click_button 'Logout'
        end

        expect(page).to_not have_content "Logged in as #{user.name}"
        expect(page).to have_button('Sign in')
      end
    end
  end
end
