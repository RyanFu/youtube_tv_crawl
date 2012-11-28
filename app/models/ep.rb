class Ep < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :drama, :counter_cache => true
  has_many :youtube_sources
end
