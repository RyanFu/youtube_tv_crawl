class Campaign < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :tickets
end
