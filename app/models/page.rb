class Page < ActiveRecord::Base

  belongs_to :user
  belongs_to :trend



  validates :user_id, presence: true
  validates :trend_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :summary, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 2000 }

  #search
	def self.search(query)
      where("title like ?", "%#{query}%")
	end
end
