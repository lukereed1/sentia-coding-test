class Person < ApplicationRecord
  validates :first_name, :species, :gender, presence: true

  has_and_belongs_to_many :affiliations, class_name: "Affiliation"
  has_and_belongs_to_many :locations, class_name: "Location"

  def first_name
    self[:first_name].capitalize if self[:first_name].present?
  end

  def formatted_locations
    locations
    .map { |location| location.name.capitalize }
    .join(", ")
  end

  def formatted_affiliations
    affiliations
    .map { |affiliation| affiliation.name.capitalize }
    .join(", ")
  end
end
