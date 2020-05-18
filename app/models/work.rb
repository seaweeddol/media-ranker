class Work < ApplicationRecord
  validates :title, presence: true
  validates :category, presence: true
  # validates :creator, presence: true
  # validates :publication_year, presence: true
end
