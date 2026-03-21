class CreatePriorities < ActiveRecord::Migration[8.1]
  def change
    create_table :priorities do |t|
      t.string :name, null: false
      t.string :color, null: false
      t.integer :level, null: false

      t.timestamps
    end

    add_index :priorities, :name, unique: true
    add_index :priorities, :level, unique: true
  end
end
