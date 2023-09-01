class Article < ApplicationRecord
  validates :title, presence: true
  has_and_belongs_to_many :categories
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  SHOR_BODY_LENGTH = 150

  after_initialize do
    # WARN: BAD PRACTICE!
    self.url = self.title.parameterize if !self.title.blank? && self.url.blank?
    self.short_body = self.short_body.truncate(SHOR_BODY_LENGTH) unless self.short_body.blank?
  end
end
