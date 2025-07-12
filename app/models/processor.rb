class Processor < ApplicationRecord
  has_many :payments
  has_many :processor_statuses
end
