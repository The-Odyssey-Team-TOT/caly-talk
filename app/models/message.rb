class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  validates :content, presence: true

  def owned_by?(user)
    self.user == user
  end
end
