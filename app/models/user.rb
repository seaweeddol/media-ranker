class User < ApplicationRecord
  has_many :votes, dependent: :delete_all
  validates :name, presence: true, uniqueness: true
end
