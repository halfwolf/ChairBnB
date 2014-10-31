class User < ActiveRecord::Base
  validates :email, :password_digest, :name, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  

  has_attached_file :avatar, styles: { medium: "300x300>",
  icon: "100x100#",
  icon_small: "50x50#" },
  default_url: "chair-sm.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  has_many( :listings,
    class_name: "Listing",
    foreign_key: :owner_id,
    primary_key: :id,
    dependent: :destroy
    )

  has_many( :reservations,
    class_name: "Reservation",
    foreign_key: :sitter_id,
    primary_key: :id,
    dependent: :destroy)
    
  has_many( :sent_messages,
    class_name: "Message",
    foreign_key: :sender_id,
    primary_key: :id,
    dependent: :destroy)
    
  has_many( :received_messages,
    class_name: "Message",
    foreign_key: :receiver_id,
    primary_key: :id,
    dependent: :destroy)
    
  has_many :written_reviews,
    class_name: "Review",
    foreign_key: :author_id,
    primary_key: :id,
    dependent: :destroy
  
  has_many :received_reviews, through: :listings, source: :reviews

  after_initialize :ensure_session_token

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    user && user.is_password?(password) ? user : nil
  end

  attr_reader :password
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(self.password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
  
  def all_messages
    Message.where("sender_id = :self_id OR receiver_id = :self_id", self_id: self.id)
  end
  
  def all_reviews
  end

end