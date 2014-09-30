class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :organizer, class_name: User.name
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :attendances
  has_many :users, through: :attendances

  def all_tags
    tags.map(&:name)
  end

  def all_tags= names
    self.tags = names.split(",").map do |t|
      Tag.where(name: t.strip).first_or_create!
    end
  end

  class << self
    def event_owner organizer_id
      User.find_by id: organizer_id
    end

    def pending_requests event_id
      Attendance.pending.where event_id: event_id
    end

    def show_accepted_attendees event_id
      Attendance.accepted.where event_id: event_id
    end

    def tag_counts
      Tag.joins(:taggings).select("tags.name, count(taggings.tag_id) as count")
        .group "taggings.tag_id"
    end

    def tagged_with name
      Tag.find_by_name!(name).events
    end
  end
end
