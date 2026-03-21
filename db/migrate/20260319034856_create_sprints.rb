class CreateSprints < ActiveRecord::Migration[8.1]
  def change
    create_table :sprints do |t|
      t.string :name, null: false
      t.text :goal
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
