class Chatroom < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  validates :name, presence: true

  def owned_by?(user)
    self.user == user
  end
end
