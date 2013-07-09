class Ticket < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :campaign
end
