# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_25_221202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "communities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.string "description", limit: 1000
    t.string "website", limit: 500
    t.string "slug"
    t.boolean "active", default: true
    t.integer "privacy", default: 100
    t.integer "status", default: 0
    t.boolean "verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["privacy"], name: "index_communities_on_privacy"
  end

  create_table "communities_games", id: false, force: :cascade do |t|
    t.uuid "community_id"
    t.uuid "game_id"
    t.index ["community_id", "game_id"], name: "index_communities_games_on_community_id_and_game_id", unique: true
    t.index ["community_id"], name: "index_communities_games_on_community_id"
    t.index ["game_id"], name: "index_communities_games_on_game_id"
  end

  create_table "event_games", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.uuid "game_id", null: false
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.index ["event_id", "game_id"], name: "index_event_games_on_event_id_and_game_id", unique: true
    t.index ["event_id"], name: "index_event_games_on_event_id"
    t.index ["game_id"], name: "index_event_games_on_game_id"
  end

  create_table "event_participation", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.uuid "gamer_id", null: false
    t.integer "status"
    t.string "response", limit: 100
    t.index ["event_id", "gamer_id"], name: "index_event_participation_on_event_id_and_gamer_id", unique: true
    t.index ["event_id"], name: "index_event_participation_on_event_id"
    t.index ["gamer_id"], name: "index_event_participation_on_gamer_id"
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "gamer_id", null: false
    t.string "name", limit: 100
    t.string "description", limit: 1000
    t.datetime "starts_at", null: false
    t.datetime "ends_at", null: false
    t.integer "type", default: 0
    t.integer "status", default: 0
    t.integer "privacy", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["gamer_id"], name: "index_events_on_gamer_id"
    t.index ["privacy"], name: "index_events_on_privacy"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["slug"], name: "index_friendly_id_slugs_on_slug"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  end

  create_table "gamers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "username"
    t.string "description", limit: 1000
    t.string "slug"
    t.integer "dedication", default: 0
    t.integer "weekday_availability", default: 0
    t.integer "weekend_availability", default: 0
    t.integer "swearing", default: 0
    t.integer "swearing_tolerance", default: 0
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.date "birth_date"
    t.integer "sex", default: 0
    t.integer "age"
    t.boolean "active", default: true
    t.integer "privacy", default: 100
    t.boolean "verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["privacy"], name: "index_gamers_on_privacy"
    t.index ["user_id"], name: "index_gamers_on_user_id"
  end

  create_table "gamers_games", id: false, force: :cascade do |t|
    t.uuid "gamer_id"
    t.uuid "game_id"
    t.index ["game_id"], name: "index_gamers_games_on_game_id"
    t.index ["gamer_id", "game_id"], name: "index_gamers_games_on_gamer_id_and_game_id", unique: true
    t.index ["gamer_id"], name: "index_gamers_games_on_gamer_id"
  end

  create_table "games", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "abbreviation"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "games_teams", id: false, force: :cascade do |t|
    t.uuid "game_id"
    t.uuid "team_id"
    t.index ["game_id", "team_id"], name: "index_games_teams_on_game_id_and_team_id", unique: true
    t.index ["game_id"], name: "index_games_teams_on_game_id"
    t.index ["team_id"], name: "index_games_teams_on_team_id"
  end

  create_table "identities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "language_proficiencies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "gamer_id"
    t.string "language"
    t.boolean "native", default: false
    t.integer "understanding", limit: 2, default: 1
    t.integer "speaking", limit: 2, default: 1
    t.integer "writing", limit: 2, default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["gamer_id", "language"], name: "index_language_proficiencies_on_gamer_id_and_language", unique: true
    t.index ["gamer_id"], name: "index_language_proficiencies_on_gamer_id"
  end

  create_table "memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "type"
    t.uuid "community_id"
    t.uuid "team_id"
    t.uuid "gamer_id"
    t.uuid "role_id"
    t.boolean "active", default: true
    t.integer "privacy", default: 100
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["community_id"], name: "index_memberships_on_community_id"
    t.index ["gamer_id"], name: "index_memberships_on_gamer_id"
    t.index ["privacy"], name: "index_memberships_on_privacy"
    t.index ["role_id"], name: "index_memberships_on_role_id"
    t.index ["team_id"], name: "index_memberships_on_team_id"
    t.index ["type"], name: "index_memberships_on_type"
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "abbreviation"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "teams", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.string "description", limit: 1000
    t.string "slug"
    t.boolean "active", default: true
    t.integer "privacy", default: 100
    t.integer "status", default: 0
    t.boolean "verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["privacy"], name: "index_teams_on_privacy"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "active", default: true
    t.boolean "is_core", default: false
    t.string "locale", default: "en"
    t.string "time_zone", default: "UTC"
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "communities_games", "communities"
  add_foreign_key "communities_games", "games"
  add_foreign_key "event_games", "events"
  add_foreign_key "event_games", "games"
  add_foreign_key "event_participation", "events"
  add_foreign_key "event_participation", "gamers"
  add_foreign_key "events", "gamers"
  add_foreign_key "gamers", "users"
  add_foreign_key "gamers_games", "gamers"
  add_foreign_key "gamers_games", "games"
  add_foreign_key "games_teams", "games"
  add_foreign_key "games_teams", "teams"
  add_foreign_key "identities", "users"
  add_foreign_key "language_proficiencies", "gamers"
  add_foreign_key "memberships", "communities"
  add_foreign_key "memberships", "gamers"
  add_foreign_key "memberships", "roles"
  add_foreign_key "memberships", "teams"
end
