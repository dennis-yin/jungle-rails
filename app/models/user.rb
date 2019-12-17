class User < ActiveRecord::Base

  has_secure_password
  
  validates :name, presence: true
  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates_uniqueness_of :email, case_sensitive: false, presence: true
  
  def authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end
