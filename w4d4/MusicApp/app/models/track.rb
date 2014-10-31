# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  bonus      :boolean          default(FALSE)
#  lyrics     :text
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
validates :album_id, :bonus, :lyrics, presence: true

belongs_to :album

end

