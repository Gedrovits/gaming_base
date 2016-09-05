class EventGame < ApplicationRecord
  # Relations
  belongs_to :event
  belongs_to :game
end
