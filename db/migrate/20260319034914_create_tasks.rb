class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.integer :position
      t.date :due_date
      t.references :column, null: false, foreign_key: true
      t.references :priority, foreign_key: true
      t.references :assignee, foreign_key: { to_table: :users }
      t.references :creator, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :tasks, [ :column_id, :position ], unique: true, where: "position IS NOT NULL"
  end
end
