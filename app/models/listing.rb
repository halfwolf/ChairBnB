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
  
  geocoded_by :full_address,
    :latitude => :lat, :longitude => :lon
  after_validation :geocode
  
  def self.bounded_listings(params)
    if params[:min].nil? || params[:max].nil?
      Listing.all
    else
      mins = params[:min].split(",")
      maxs = params[:max].split(',')
      lon_min = mins[0].to_f
      lon_max = maxs[0].to_f
      lat_min = mins[1].to_f
      lat_max = maxs[1].to_f
      query = "(lat BETWEEN :lat_min AND :lat_max) AND (lon BETWEEN :lon_min AND :lon_max)"
      Listing.all.where(query, lat_min: lat_min, lat_max: lat_max, lon_min: lon_min, lon_max: lon_max)
    end
  end


  
  def pending_reservations?
    self.reservations.where("status = 'PENDING' AND end_date > :now", now: DateTime.now).length > 0
  end  
  
  def valid_reservations
    self.reservations.where("(status = 'PENDING' OR status = 'APPROVED') AND end_date > :now", now: DateTime.now)
  end
  
  def geoJSON
    {
      type: "Feature",
        geometry: {
          type: "Point",
          coordinates: [
            self.lon, 
            self.lat
          ]
        },
        properties: {
          title: self.name,
          "marker-color" => "#000000",
          "marker-size" => "medium",
          "marker-symbol" => "building"
        } 
      }
  
  end
  
  def fixed_zipcode
    zip_string = self.zip_code.to_s
    while zip_string.length < 5
      zip_string = "0" + zip_string
    end
    zip_string
  end
  
  def full_address
    street = (self.street + ",") || ""
    city = (self.city + ",") || ""
    (street + " " + city + " " + self.fixed_zipcode).strip
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
