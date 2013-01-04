class DeviceWatchInfo < ActiveRecord::Base
  # attr_accessible :title, :body
  serialize :watched_ep
  belongs_to :drama
end
