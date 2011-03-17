# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 21) do

  create_table "facebook_templates", :force => true do |t|
    t.string "template_name", :null => false
    t.string "content_hash",  :null => false
    t.string "bundle_id"
  end

  add_index "facebook_templates", ["template_name"], :name => "index_facebook_templates_on_template_name", :unique => true

  create_table "family_members", :force => true do |t|
    t.string   "relashionship"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "survivor_id"
  end

  add_index "family_members", ["survivor_id"], :name => "index_family_members_on_survivor_id"
  add_index "family_members", ["user_id"], :name => "index_family_members_on_user_id"

  create_table "friends", :force => true do |t|
    t.string   "level"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "survivor_id"
  end

  add_index "friends", ["survivor_id"], :name => "index_friends_on_survivor_id"
  add_index "friends", ["user_id"], :name => "index_friends_on_user_id"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.text     "description"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "country",      :default => "Haiti"
    t.string   "kind"
    t.string   "web_site_url"
    t.string   "picture_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "duplicate",    :default => false
    t.integer  "user_id"
  end

  create_table "notes", :force => true do |t|
    t.datetime "entry_date"
    t.string   "author_name"
    t.string   "author_email"
    t.string   "author_phone"
    t.datetime "source_date"
    t.boolean  "found"
    t.string   "email_of_found_person"
    t.string   "phone_of_found_person"
    t.string   "last_known_location"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "person_id"
    t.string   "linked_person_id"
  end

  add_index "notes", ["linked_person_id"], :name => "index_notes_on_linked_person_id"
  add_index "notes", ["person_id"], :name => "index_notes_on_person_id"

  create_table "notifications", :force => true do |t|
    t.string   "name"
    t.datetime "last_notified_on"
    t.integer  "user_id"
  end

  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "persons", :force => true do |t|
    t.datetime "entry_date"
    t.string   "author_name"
    t.string   "author_email"
    t.string   "author_phone"
    t.string   "source_name"
    t.datetime "source_date"
    t.string   "source_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "home_city"
    t.string   "home_state"
    t.string   "home_neighborhood"
    t.string   "home_street"
    t.string   "home_zip"
    t.string   "photo_url"
    t.text     "other"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "survivor_id"
  end

  add_index "persons", ["survivor_id"], :name => "index_persons_on_survivor_id"
  add_index "persons", ["user_id"], :name => "index_persons_on_user_id"

  create_table "profiles", :force => true do |t|
    t.string   "salutation"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "suffix"
    t.string   "nickname"
    t.text     "about_yourself"
    t.string   "email"
    t.string   "web_site_url"
    t.string   "blog_url"
    t.string   "twitter"
    t.string   "time_zone"
    t.string   "mobile_phone"
    t.string   "work_phone"
    t.string   "home_phone"
    t.string   "photo_url"
    t.boolean  "share_info_with_all", :default => true
    t.boolean  "allow_comments",      :default => true
    t.string   "city"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "survivor_id"
    t.string   "citizen_of"
  end

  add_index "profiles", ["survivor_id"], :name => "index_profiles_on_survivor_id"
  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "reminders", :force => true do |t|
    t.string   "kind"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "reminders", ["user_id"], :name => "index_reminders_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "stats", :force => true do |t|
    t.integer  "users_count"
    t.integer  "survivors_count"
    t.integer  "survivor_updates_count"
    t.integer  "locations_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "stats", ["user_id"], :name => "index_stats_on_user_id"

  create_table "survivor_updates", :force => true do |t|
    t.string   "status"
    t.text     "details"
    t.boolean  "confirmed"
    t.string   "confirmation_source"
    t.boolean  "allow_comments",      :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "survivor_id"
    t.boolean  "tweeted",             :default => false
  end

  add_index "survivor_updates", ["survivor_id"], :name => "index_survivor_updates_on_survivor_id"
  add_index "survivor_updates", ["user_id"], :name => "index_survivor_updates_on_user_id"

  create_table "survivors", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "profile_id"
    t.integer  "location_id"
    t.string   "last_status"
    t.boolean  "tweeted",     :default => false
    t.boolean  "duplicate",   :default => false
  end

  add_index "survivors", ["profile_id"], :name => "index_survivors_on_profile_id"
  add_index "survivors", ["user_id"], :name => "index_survivors_on_user_id"

  create_table "users", :force => true do |t|
    t.integer  "facebook_id",     :limit => 8,                    :null => false
    t.string   "session_key"
    t.boolean  "superuser",                    :default => false
    t.datetime "last_login_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id"

end
