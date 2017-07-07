class Cuepoint < ApplicationRecord
  validates :name, length: { in: 5..20 }, uniqueness: true
  has_and_belongs_to_many :campaigns
end