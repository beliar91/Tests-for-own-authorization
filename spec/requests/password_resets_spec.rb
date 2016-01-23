require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  describe "GET /password_resets" do
    it "Password and password_confirmation should match" do
      user = FactoryGirl.create(:user, password_sent_at: 1.hours.ago)
      visit edit_password_reset_path(user.password_reset_token)
      fill_in "Password", with: "Test"
      fill_in "Password confirmation", with: "Test"

      click_button("Update Password")
      expect(page).to have_content("Password has been reset")
    end

    it "reports when password token has expired" do

      user = FactoryGirl.create(:user, password_sent_at: 3.hours.ago)
      visit edit_password_reset_path(user.password_reset_token)
      fill_in "Password", with: "Test"
      fill_in "Password confirmation", with: "Test"

      click_button("Update Password")
      expect(page).to have_content("Password expired")

    end

    it "raises record not found when password token is invalid" do
      #exception

      FactoryGirl.create(:user, password_sent_at: 1.hours.ago)
      expect{visit edit_password_reset_path("aaa")}.to raise_exception (ActiveRecord::RecordNotFound)

    end

  end
end
