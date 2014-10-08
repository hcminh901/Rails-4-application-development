class Organization < ActiveRecord::Base
  resourcify
  has_and_belongs_to_many :users
end
