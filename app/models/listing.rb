class Listing < ActiveRecord::Base
  validates :name, :owner_id, :price, :room_type, :chair_type, :seats, :zip_code, presence: true

  belongs_to( :owner,
  class_name: "User",
  foreign_key: :owner_id,
  primary_key: :id
  )

  has_many( :reservations,
    class_name: "Reservation",
    foreign_key: :chair_id,
    primary_key: :id, 
    dependent: :destroy)
    
    has_many(:pictures)
    
  has_many :reviews, through: :reservations, source: :review

  def pending_reservations?
    self.reservations.where("status = 'PENDING' AND end_date > :now", now: DateTime.now).length > 0
  end  
  
  def valid_reservations
    self.reservations.where("(status = 'PENDING' OR status = 'APPROVED') AND end_date > :now", now: DateTime.now)
  end
  
  def fixed_zipcode
    zip_string = self.zip_code.to_s
    while zip_string.length < 5
      zip_string = "0" + zip_string
    end
    zip_string
  end
  
  def full_address
    self.street + " " + self.city + " " + self.fixed_zipcode
  end
  
  def review_score
    total = 0
    count = 0
    self.reviews.each do |review|
      total += review.rating
      count += 1
    end
    count > 0 ? total / count : 0
  end
  
  def average_reviews
    stars = "\u2606" * self.review_score
    stars == 0 ? "No Reviews" : stars
  end
    
end
