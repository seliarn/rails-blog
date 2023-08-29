class Article < ApplicationRecord
  validates :title, presence: true
  has_and_belongs_to_many :categories
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  before_validation do
    self.url = self.title.parameterize if self.url.blank?
    self.short_body = self.short_body.truncate(150)
  end
end
