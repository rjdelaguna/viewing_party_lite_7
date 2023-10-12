require "rails_helper"

RSpec.describe "the movies viewing party new page", type: :feature do
  describe "When a user visits the movies viewing parties new page" do
    before :each do
      @user = User.create!(name: "John Smith", email: "jsmith@aol.com")
      @user2 = User.create!(name: "Jane Doe", email: "jdoe@aol.com")

    end
    
    it "has a form with duration, date, and time fields, and all existing users with checkboxes to be connected to the party", :vcr do
      visit user_discover_path(@user)

      click_button "Discover Top Rated Movies"

      click_on "The Godfather"

      click_button "Create Viewing Party for The Godfather"

      expect(current_path).to eq("/users/#{@user.id}/movies/238/viewing_party/new")

      expect(page).to have_selector("Duration")
      expect(page).to have_selector("When")
      expect(page).to have_selector("Start Time")
      expect(page).to have_selector(@user2.name)
      expect(page).to have_button("Create Party")

      within("#users") do
        expect(page).to have_content(@user2.name)
      end

    end
  end
end