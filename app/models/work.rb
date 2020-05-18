class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
  # validates :creator, presence: true
  # validates :publication_year, presence: true

  def self.top_work
    # TODO add logic to find work with most votes
    return Work.find(Work.pluck(:id).sample)
  end

  def self.top_ten_works(category)
    # find all by category
    all_works = Work.where(category: category)
    
    # sort by votes

    # return first ten items
    return all_works.sample(10)
  end
end
