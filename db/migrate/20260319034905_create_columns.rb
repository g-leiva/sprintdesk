class CreateColumns < ActiveRecord::Migration[8.1]
  def change
    create_table :columns do |t|
      t.string :name, null: false
      t.integer :position, null: false
      t.references :sprint, null: false, foreign_key: true

      t.timestamps
    end

    add_index :columns, [ :sprint_id, :position ], unique: true
  end
end
