class Article < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_article,
                  against: [:headline, :caption],
                  associated_against: { rich_text_content: [:body] },
                  using: { tsearch: { dictionary: 'english' } }

  enum status: {unpublished: 0, published: 1}
  validates :headline, :caption, :content, :picture_alt, presence: true

  belongs_to :category
  belongs_to :subcategory, optional: true
  belongs_to :team, optional: true
  has_one_attached :picture
  has_rich_text :content
  has_many :comments, dependent: :destroy

  scope :by_category, ->(category_id) { where(category_id: category_id) if category_id.present? }
  scope :by_subcategory, ->(subcategory_id) { where(subcategory_id: subcategory_id) if subcategory_id.present? }
  scope :by_team, ->(team_id) { where(team_id: team_id) if team_id.present? }
end