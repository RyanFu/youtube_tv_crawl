class DeviceWatchInfo < ActiveRecord::Base
  # attr_accessible :title, :body
  serialize :watched_ep
end
