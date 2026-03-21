# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_19_034914) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "columns", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.integer "position", null: false
    t.bigint "sprint_id", null: false
    t.datetime "updated_at", null: false
    t.index ["sprint_id", "position"], name: "index_columns_on_sprint_id_and_position", unique: true
    t.index ["sprint_id"], name: "index_columns_on_sprint_id"
  end

  create_table "priorities", force: :cascade do |t|
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.integer "level", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["level"], name: "index_priorities_on_level", unique: true
    t.index ["name"], name: "index_priorities_on_name", unique: true
  end

  create_table "sprints", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "end_date", null: false
    t.text "goal"
    t.string "name", null: false
    t.date "start_date", null: false
    t.bigint "team_id", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_sprints_on_team_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "assignee_id"
    t.bigint "column_id", null: false
    t.datetime "created_at", null: false
    t.bigint "creator_id"
    t.text "description"
    t.date "due_date"
    t.integer "position"
    t.bigint "priority_id"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_id"], name: "index_tasks_on_assignee_id"
    t.index ["column_id", "position"], name: "index_tasks_on_column_id_and_position", unique: true, where: "(\"position\" IS NOT NULL)"
    t.index ["column_id"], name: "index_tasks_on_column_id"
    t.index ["creator_id"], name: "index_tasks_on_creator_id"
    t.index ["priority_id"], name: "index_tasks_on_priority_id"
  end

  create_table "team_memberships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "role", null: false
    t.bigint "team_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["team_id"], name: "index_team_memberships_on_team_id"
    t.index ["user_id", "team_id"], name: "index_team_memberships_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_team_memberships_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "columns", "sprints"
  add_foreign_key "sprints", "teams"
  add_foreign_key "tasks", "columns"
  add_foreign_key "tasks", "priorities"
  add_foreign_key "tasks", "users", column: "assignee_id"
  add_foreign_key "tasks", "users", column: "creator_id"
  add_foreign_key "team_memberships", "teams"
  add_foreign_key "team_memberships", "users"
end
