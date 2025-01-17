class Affiliation < ApplicationRecord
  validates :name, presence: true
  has_and_belongs_to_many :people, class_name: "Person"
end
