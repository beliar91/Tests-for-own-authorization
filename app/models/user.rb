class User < ActiveRecord::Base
  validates :password, confirmation: true
  has_secure_password
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end

