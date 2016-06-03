class Tv < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :introduction, presence: true, length: { maximum: 160 }
  validates :theme_color, presence: true
  
  has_many :tvshows
end
