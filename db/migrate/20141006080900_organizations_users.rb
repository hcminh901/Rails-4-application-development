class OrganizationsUsers < ActiveRecord::Migration
  def change
    create_table :organizations_users, id: false do |t|
      t.references :user, null: false
      t.references :organization, null: false
    end
    add_index :organizations_users, [:user_id, :organization_id], unique: true
  end
end
