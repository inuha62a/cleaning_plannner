class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum :group_role, { owner: 0, member: 1, guest: 2 }
end
