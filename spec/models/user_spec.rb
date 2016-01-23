require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryGirl.create(:user)}

  it "generates a unique password_reset token each time" do
    user.send_password_reset
    last_token = user.password_reset_token
    user.send_password_reset
    expect(user.password_reset_token).not_to eq(last_token)
  end

  it "saves the time the password reset was sent" do

    user.send_password_reset
    date_now = user.password_sent_at
    expect(date_now).to be_present
    #password_sent_at
  end

  it "The email should be delivered to the user" do
    user.send_password_reset
    expect(ActionMailer::Base.deliveries.last.to.first).to eq(user.email)
  end
end
