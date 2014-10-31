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

require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
