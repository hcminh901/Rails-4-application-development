class AddStateColumnToAttendanceTable < ActiveRecord::Migration
  def change
    add_column :attendances, :state, :string
  end
end
