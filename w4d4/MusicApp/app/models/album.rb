# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  name       :string(255)      not null
#  live       :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
  validates :band_id, :name, presence: true
  validates :live, inclusion: { in: [true, false] }
  belongs_to :band
  has_many :tracks, dependent: :destroy

end
