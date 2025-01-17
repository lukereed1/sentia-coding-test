class CreateJoinTablePeopleLocations < ActiveRecord::Migration[8.0]
  def change
    create_join_table :people, :locations do |t|
      # t.index [:person_id, :location_id]
      # t.index [:location_id, :person_id]
    end
  end
end
