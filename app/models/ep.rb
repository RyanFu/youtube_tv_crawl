class Ep < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :drama, :counter_cache => true
  has_many :youtube_sources

  scope :drama_eps, lambda { |drama_id| where('drama_id = (?)', drama_id).select('id,num') }
end
