class Drama < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :area
  has_many :eps
  scope :area_dramas, lambda { |area_id| where('area_id = (?)', area_id).select('id') }
end
