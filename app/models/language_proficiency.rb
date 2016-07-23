class LanguageProficiency < ApplicationRecord
  belongs_to :gamer
  
  PROFICIENCIES = { none: 0, poor: 1, below_average: 2, average: 3, good: 4, excellent: 5 }.freeze
  # none, poor, below average, average, good, excellent
  # никакое, слабое, ниже среднего, среднее, хорошее, идеальное

  enum understanding: PROFICIENCIES, _prefix: true
  enum speaking:      PROFICIENCIES, _prefix: true
  enum writing:       PROFICIENCIES, _prefix: true
end
