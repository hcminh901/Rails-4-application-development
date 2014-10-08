class Pin < ActiveRecord::Base
  paginates_per 10

  extend FriendlyId
  friendly_id :name, use: :slugged

  searchable do
    text :name, :image
    integer :board_id
  end

  mount_uploader :image, ImageUploader

  belongs_to :board

  scope :order_by_created_at, ->{order(:created_at)}

  def repin_post board_id
    Pin.create! name: self.name, board_id: board_id, image: self.image
  end

  class << self
    def send_newsletter
      @users = User.all
      @users.each do |u|
        @pins = self.all limit: 5
        Newsletter.letter(u, @pins).deliver
      end
    end

    def search_pin search_key
      @search = self.search do
        fulltext "#{search_key}"
      end
      @search.results
    end
  end
end
