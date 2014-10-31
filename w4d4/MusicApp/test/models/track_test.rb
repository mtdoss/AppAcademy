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

require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
