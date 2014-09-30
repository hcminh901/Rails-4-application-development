class Attendance < ActiveRecord::Base
  include Workflow
    workflow_column :state

  workflow do
    state :request_sent do
      event :accept, transitions_to: :accepted
      event :reject, transitions_to: :rejected
    end
    state :accepted
    state :rejected
  end

  belongs_to :event
  belongs_to :user

  scope :accepted, ->{where state: :accepted}
  scope :pending, ->{where state: :request_sent}

  class << self
    def join_event user_id, event_id, state
      create user_id: user_id, event_id: event_id, state: state
    end
  end
end
