class User < ApplicationRecord
  validates :profile, presence: true
end
