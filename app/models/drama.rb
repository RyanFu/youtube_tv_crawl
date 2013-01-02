class Drama < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :area
  has_many :eps
  scope :show_dramas, where(["is_show = ? ", true ])
  scope :show_dramas_v2, where(["is_show_v2 = ? ", true ])
end
