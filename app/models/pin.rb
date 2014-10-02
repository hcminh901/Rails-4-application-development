class Pin < ActiveRecord::Base
  paginates_per 10

  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :image, ImageUploader

  belongs_to :board

  scope :order_by_created_at, ->{order(:created_at)}
end
