class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, :session_token, uniqueness: true
  
  has_many :cats
  
  after_initialize do 
    ensure_session_token
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save! #update?
    self.session_token
  end
  
  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return nil if user.nil?
    
    
     user.is_password?(password) ? user : nil
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
