class Page < ActiveRecord::Base
  attr_accessible :user_id, :trend_id, :title, :summary, :body

  belongs_to :user
  belongs_to :trend



  validates :user_id, presence: true
  validates :trend_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :summary, presence: true, length: { maximum: 255 }
  validates :body, presence: true
end
