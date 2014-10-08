class Menu < ActiveRecord::Base
  require "csv"
  belongs_to :restaurant
  has_many :items
  accepts_nested_attributes_for :items, allow_destroy: true

  class << self
    def export_to_csv
      CSV.generate do |csv|
        csv << column_names
        all.each do |menu|
          csv << menu.attributes.values_at(*column_names)
        end
      end
    end
  end
end
