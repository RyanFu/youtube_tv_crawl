class Area < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :dramas
end
