class Page
  include Mongoid::Document

  field :title, type: String
  field :body, type: String
  field :page_type, type: String

  has_many :child_pages, class_name: Page.name, inverse_of: :parent_page
  belongs_to :parent_page, class_name: Page.name, inverse_of: :child_page

  validates :title, presence: true
  validates :body, presence: true

  PAGE_TYPE = %w(Home News Video Contact Team Careers)

  scope :home, ->{where page_type: "Home"}
end
