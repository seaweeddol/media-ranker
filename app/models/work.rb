class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
  # validates :creator, presence: true
  # validates :publication_year, presence: true

  def self.top_work
    top_work = Work.first
    Work.all.each do |work|
      if work.votes.count > top_work.votes.count
        top_work = work
      end
    end

    return top_work
  end

  def self.top_ten_works(category)
    # find all by category
    all_works = Work.where(category: category)
    
    # sort by votes

    # return first ten items
    return all_works.sample(10)
  end
end
