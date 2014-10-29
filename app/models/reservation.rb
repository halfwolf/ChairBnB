class Reservation < ActiveRecord::Base
  
  validates :chair_id, :start_date, :end_date, :sitter_id, :status, presence: true
  
  belongs_to( :sitter,
    class_name: "User",
    foreign_key: :sitter_id,
    primary_key: :id)
  
  belongs_to :chair, 
  class_name: "Listing",
  foreign_key: :chair_id,
  primary_key: :id
  
  has_one :review, dependent: :destroy


  def approve!
    raise "not pending" unless self.status == "PENDING"
    transaction do 
      self.status = "APPROVED"
      self.save!
      
      overlapping_pending_requests.update_all(status: "DENIED")
    end
  end
  
  def deny!
    self.status = "DENIED"
    self.save!
  end

  def review_ready?
    self.end_date < Time.now && self.status == "APPROVED" && self.review.nil?
  end
  
  private
  
  def overlapping_reservations
    Reservation
      .where("(:id IS NULL) OR (id != :id)", id: self.id)
      .where(chair_id: chair_id)
      .where(<<-SQL, start_date: start_date, end_date: end_date)
        NOT( (start_date > :end_date) OR (end_date < :start_date) )
      SQL
  end
  
  def overlapping_pending_requests
    overlapping_reservations.where("status = 'PENDING'")
  end

  def overlapping_approved_requests
    overlapping_reservations.where("status = 'APPROVED'")
  end
  


end
