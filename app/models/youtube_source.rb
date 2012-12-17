class YoutubeSource < ActiveRecord::Base
  attr_accessible :id, :link, :ep_id
  belongs_to :ep
  scope :ep_youtube_sources, lambda { |ep_id| where('ep_id = (?)', ep_id).select('ep_id,link') }
end
