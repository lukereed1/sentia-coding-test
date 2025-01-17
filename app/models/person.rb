class Person < ApplicationRecord
  validates :first_name, :species, :gender, presence: true

  has_and_belongs_to_many :affiliations, class_name: "Affiliation"
  has_and_belongs_to_many :locations, class_name: "Location"

  def first_name
    # Skip capitalisation if name contains nums or -
    return self[:first_name] if self[:first_name]&.match?(/[\d-]/)
    self[:first_name]&.capitalize
  end

  def last_name
    return self[:last_name] if self[:last_name]&.match?(/[\d-]/)
    self[:last_name]&.capitalize
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
