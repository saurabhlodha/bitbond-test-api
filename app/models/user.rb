class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /@/
  has_many :identities

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    user = identity.user
    access_token = auth.credentials.token
    secret = auth.credentials.secret

    # Create user if already not present
    if user.nil?
      email = auth.info.email
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          email: email,
          password: Devise.friendly_token[0,20]
        )
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
    end
    identity.access_token = access_token
    identity.secret = secret
    identity.save!
    user
  end
end
