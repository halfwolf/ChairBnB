class Reservation < ActiveRecord::Base
  
  belongs_to( :sitter,
    class_name: "User",
    foreign_key: :sitter_id,
    primary_key: :id)
  
  belongs_to :chair
  
  has_many :reviews

end
