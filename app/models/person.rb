class Person < ApplicationRecord
  has_and_belongs_to_many :affiliations, class_name: "Affiliation"
  has_and_belongs_to_many :locations, class_name: "Location"
end
