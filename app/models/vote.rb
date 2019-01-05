class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :ownerable, polymorphic: true
end
