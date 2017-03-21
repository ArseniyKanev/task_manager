class Task < ActiveRecord::Base

  include AASM

  belongs_to :user

  validates :user_id, :name, presence: true

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
