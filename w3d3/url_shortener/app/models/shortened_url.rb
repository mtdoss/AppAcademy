class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, :submitter_id, presence: true
  validates :short_url, :long_url, uniqueness: true
  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  ) 
  
  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :url_id,
    primary_key: :id
  )
  
  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )
  
  def self.random_code  
    loop do
      short_url = SecureRandom.urlsafe_base64
      return short_url unless ShortenedUrl.exists?(short_url: short_url)
    end
  end
  
  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      submitter_id: user.id, 
      long_url: long_url, 
      short_url: ShortenedUrl.random_code
      )
  end
  
  def num_clicks
    visits.count
  end
  
  def num_uniques
    # Visit.where(url_id: id).distinct.count(:user_id)
    visitors.count
  end
  
  def num_recent_uniques
    visitors.where("visits.created_at > ?", 10.minutes.ago).count
    # self.visits.where("created_at > ?", 10.minutes.ago).distinct.count(:user_id)
  end
  
end