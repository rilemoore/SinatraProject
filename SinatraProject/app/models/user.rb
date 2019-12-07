class User < ActiveRecord::Base
    has_many :vehicles
    has_secure_password
    validates :password, presence: true
    validates :password, length: {minimum: 6}
    validates :username, uniqueness: true
    validates :username, presence: true

end
  