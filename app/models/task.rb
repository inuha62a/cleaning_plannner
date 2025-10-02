class Task < ApplicationRecord
  belongs_to :user
  belongs_to :location
  belongs_to :group
end
