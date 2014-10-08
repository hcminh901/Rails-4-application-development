class Board < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  searchable do
    text :description, :title
    integer :user_id
  end

  has_many :pins
  belongs_to :user

  validates :title, presence: true

  class << self
    def search_board search_key
      @search = self.search do
        fulltext "#{search_key}"
      end
      @search.results
    end
  end
end
