class Restaurant < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :menus
  belongs_to :organization
  validates :name, presence: true
end
