class Tvshow < ActiveRecord::Base
  belongs_to :tv
  validates :tv_id, presence: true
  validates :introduction, presence: true, length: { maximum: 160 }
  validates :video_url, presence: true
end
