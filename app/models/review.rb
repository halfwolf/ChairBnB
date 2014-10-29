class Review < ActiveRecord::Base
  
  belongs_to :reservation
  
  belongs_to( :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id)
    
  
end
