# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  
  validates :name, presence: true, uniqueness: true
  validates :email, :password_digest, :session_token, presence: true
  
  after_initialize :ensure_session_token
  has_many :subs
  has_many :posts, foreign_key: :author_id
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    
    #self.session_token
  end
  
  
  def self.find_by_credentials(name, password)
    @user = self.find_by(name: name)
    return nil if @user.nil?
    
    @user.is_password?(password) ? @user : nil
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
  
end
