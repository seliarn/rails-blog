class Article < ApplicationRecord
  validates :title, presence: true
  # validates :short_body, length: { maximum: 150 }
  # has_many :article_category
  # has_many :category, through: :article_category
  has_and_belongs_to_many :categories

  before_validation do
    self.url = self.title.parameterize if self.url.blank?
    self.short_body = self.short_body.truncate(150)
  end
end
