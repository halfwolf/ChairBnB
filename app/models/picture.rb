class Picture < ActiveRecord::Base
  validates :listing_id, presence: true
  
  has_attached_file :pic, styles: { medium: "300x300>",
  icon: "100x100#"},
  default_url: "https://s3.amazonaws.com/chairbnb/public/chair-def.png"
  
  validates_attachment_content_type :pic, content_type: /\Aimage\/.*\Z/
  
end