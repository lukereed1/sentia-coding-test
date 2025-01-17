class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def import
    require "csv"
    return redirect_to request.referer, alert: "No file uploaded" unless params[:file]

    file = File.open(params[:file])

    CSV.foreach(file, headers: true) do |row|
      next unless row["Affiliations"] # Skips user without an affiliation
      new_person = Person.new

      # Name
      name = row["Name"]&.split(" ")
      new_person.first_name = name[0]
      new_person.last_name = name[1]

      # Location/s
      if row["Location"].include?(",") # Person has multiple locations
        all_locations = row["Location"].split(",").map { |location| normalise(location) }
        all_locations.each do |location|
          loc = Location.find_or_create_by(name: location)
          new_person.locations << loc
        end
      else # Person has one location
        location = normalise(row["Location"])
        loc = Location.find_or_create_by(name: location)
        new_person.locations << loc
      end

      # Affiliation/s
      if row["Affiliations"].include?(",") # Person has multiple affiliations
        all_affiliations = row["Affiliations"].split(",").map { |affiliation| normalise(affiliation) }
        all_affiliations.each do |affiliation|
          affil = Affiliation.find_or_create_by(name: affiliation)
          new_person.affiliations << affil
        end
      else
        affiliation = normalise(row["Affiliations"])
        affil = Affiliation.find_or_create_by(name: affiliation)
        new_person.affiliations << affil
      end

      # Other Details
      new_person.species = normalise(row["Species"])
      new_person.weapon = normalise(row["Weapon"])
      new_person.vehicle = normalise(row["Vehicle"])
      new_person.gender = parse_gender(row["Gender"])

      new_person.save
    end
  end

  # Converts to lowercase and removes any leading/tailing whitespace or special characters
  def normalise(text)
    text&.downcase&.strip&.gsub(/[^a-zA-Z0-9\s'-]/, "")
  end

  def parse_gender(text)
    if text&.downcase == "m"
      "male"
    elsif text&.downcase == "f"
      "female"
    else
      text&.downcase
    end
  end
end
