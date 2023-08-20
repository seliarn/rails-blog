class Article < ApplicationRecord
  validates :title, presence: true

  before_validation do
    self.url = self.title.parameterize if self.url.blank?
  end
end
