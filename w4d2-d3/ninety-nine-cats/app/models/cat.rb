# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string(255)      not null
#  name        :string(255)      not null
#  sex         :string(255)      not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  COLORS = ["white", "calico", "magenta", "black"]
  belongs_to(
    :owner,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  SEX = ["m","f"]
  
  
  validates :birth_date, :sex, :name, :color,  presence: true
  validates :birth_date, :timeliness => {:on_or_before => lambda { Date.current }, :type => :date}
  validates :color, inclusion: COLORS
  validates :sex, inclusion: SEX
  
  def age
    Date.current.year - birth_date.year
  end
  
  has_many(:cat_rental_requests, dependent: :destroy)
end
