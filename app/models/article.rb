class Article < ApplicationRecord
  SHOR_BODY_LENGTH = 150

  validates :title, presence: true
  validates :user_id, presence: true
  validates_length_of :short_body, maximum: SHOR_BODY_LENGTH, allow_blank: true

  has_and_belongs_to_many :categories
  belongs_to :author, class_name: 'User', foreign_key: :user_id


  after_initialize do
    # WARN: BAD PRACTICE!
    self.url = self.title.parameterize if !self.title.blank? && self.url.blank?
  end
end
