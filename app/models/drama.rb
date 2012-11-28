class Drama < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :area
  has_many :eps
end
