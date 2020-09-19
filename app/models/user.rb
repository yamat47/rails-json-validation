class User < ApplicationRecord
  validates :profile, presence: true

  validates_with User::ProfileValidator, if: ->(user) { user.profile.present? }
end
