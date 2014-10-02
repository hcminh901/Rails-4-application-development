class RecreateOldThumbnails < ActiveRecord::Migration
  def change
    Pin.all.each {|p| p.image.recreate_versions! if p.image.present?}
  end
end
