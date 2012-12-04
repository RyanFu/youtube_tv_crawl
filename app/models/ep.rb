class Ep < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :drama
  has_many :youtube_sources
  
  scope :by_num_order, order('num DESC')
  scope :drama_eps, lambda { |drama_id| where('drama_id = (?)', drama_id).select('id,num') }
end
