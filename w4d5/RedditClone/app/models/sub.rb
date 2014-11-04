# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  description :string(255)      not null
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Sub < ActiveRecord::Base
  validates :title, :description, :user_id, presence: true
  validates :title, uniqueness: true
  
  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  has_many :posts
end
