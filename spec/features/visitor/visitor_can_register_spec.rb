require 'rails_helper'

describe "As a visitor" do
  context "when I visit root and click register" do
    scenario "I am forwarded into register path" do
      visit root_path

      click_on "Register"

      expect(current_path).to eq("/register")
    end
  end

  context "when I visit /register and fill in info" do
    scenario "I am redirected to dashboard" do
      visit register_path

      expect(ActionMailer::Base.deliveries.size).to eq(0)
      within('main') do
        fill_in "Name", with: "Jane123"
        fill_in "Email", with: "jane@gmail.com"
        fill_in "Password", with: "test1"
        fill_in "Password confirmation", with: "test1"
        click_on "Register"
      end

      expect(page).to have_content("Logged in as Jane123")
      expect(page).to have_content("This account has not yet been activated.  Please check your email.")
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      expect(current_path).to eq("/dashboard")
    end

    scenario "with non-matching password confirmation, am still on register path" do
      visit register_path

      within('main') do
        fill_in "Name", with: "Jane123"
        fill_in "Email", with: "jane@gmail.com"
        fill_in "Password", with: "test1"
        fill_in "Password confirmation", with: "test2"
        click_on "Register"
      end

      expect(page).to_not have_content("Logged in as Jane123")
      expect(page).to_not have_content("This account has not yet been activated.  Please check your email.")
      within('main') { expect(page).to have_field("Name", with: "Jane123") }
    end
  end
end
