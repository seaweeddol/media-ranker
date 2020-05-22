class Work < ApplicationRecord
  has_many :votes, dependent: :delete_all
  validates :title, presence: true, uniqueness: {scope: :category}
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
    # find all works in category
    all_works = Work.where(category: category).joins("left join votes on votes.work_id = works.id")
    
    # group all_works into an array and then order by count of votes
    sorted_works = all_works.group('works.id').order('count(votes.id) DESC')

    # return first ten items
    return sorted_works[0..9]
  end
end
