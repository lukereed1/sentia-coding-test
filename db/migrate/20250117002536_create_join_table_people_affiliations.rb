class CreateJoinTablePeopleAffiliations < ActiveRecord::Migration[8.0]
  def change
    create_join_table :people, :affiliations do |t|
      # t.index [:person_id, :affiliation_id]
      # t.index [:affiliation_id, :person_id]
    end
  end
end
