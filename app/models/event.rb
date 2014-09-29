class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :organizers, class_name: User.name
  has_many :taggings
  has_many :tags, through: :taggings

  def all_tags
    tags.map(&:name).join ","
  end

  def all_tags= names
    self.tags = names.split(",").map do |t|
      Tag.where(name: t.strip).first_or_create!
    end
  end

  class << self
    def tagged_with name
      Tag.find_by_name!(name).events
    end
  end
end
