class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments
  has_many :votes, as: :ownerable
end
