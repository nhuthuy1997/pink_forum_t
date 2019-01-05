class Topic < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :votes, as: :ownerable
end
