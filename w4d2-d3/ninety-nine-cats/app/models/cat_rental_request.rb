# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string(255)      default("PENDING"), not null
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  STATUS = ["PENDING", "APPROVED", "DENIED"]
  
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: STATUS
  validate :overlapping_approved_requests
  # after_initialize do
  #   puts "SETTING STATUS *******************************"
  #   self.status ||= "PENDING"
  # end
  
  belongs_to(:cat)
    
  def approve!
    self.status = "APPROVED"
    self.save!
    overlapping_requests.each { |request| request.deny! }
  end

  def deny!
    self.status = 'DENIED'
  end
  
  def overlapping_requests
    all_requests = CatRentalRequest.all
    
    all_requests.select do |request|#self.?
      start_date.between?(request.start_date, request.end_date) ||
        end_date.between?(request.start_date, request.end_date)
    end
  end
  
  def overlapping_approved_requests
    any_requests = overlapping_requests.any? do |request|
      request.status == "APPROVED"
      end  
      if any_requests
        errors[:cat_id] << "Date taken, choose another cat!"
      end
  end
end
