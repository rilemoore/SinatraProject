class User < ActiveRecord::Base
    has_many :vehicles
    has_secure_password
end
  