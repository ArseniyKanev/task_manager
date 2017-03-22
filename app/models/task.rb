class Task < ActiveRecord::Base

  include AASM

  belongs_to :user
  has_many :attachments, dependent: :destroy

  validates :user_id, :name, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true
  delegate :email, to: :user

  aasm column: :state do
    state :new, initial: true
    state :started
    state :finished

    event :start do
      transitions from: :new, to: :started
    end

    event :finish do
      transitions from: :started, to: :finished
    end
  end

end
