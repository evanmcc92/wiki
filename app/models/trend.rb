class Trend < ActiveRecord::Base
  attr_accessible :user_id, :title

  belongs_to :user
  has_many :pages

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
end
