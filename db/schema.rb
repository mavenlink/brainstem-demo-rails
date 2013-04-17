# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130409165608) do

  create_table "features", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "widget_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "features", ["created_at"], :name => "index_features_on_created_at"
  add_index "features", ["updated_at"], :name => "index_features_on_updated_at"
  add_index "features", ["widget_id"], :name => "index_features_on_widget_id"

  create_table "locations", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "locations", ["created_at"], :name => "index_locations_on_created_at"
  add_index "locations", ["name"], :name => "index_locations_on_name"

  create_table "widgets", :force => true do |t|
    t.string   "name",                           :null => false
    t.boolean  "legacy",      :default => false, :null => false
    t.integer  "location_id",                    :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "widgets", ["created_at"], :name => "index_widgets_on_created_at"
  add_index "widgets", ["location_id"], :name => "index_widgets_on_location_id"
  add_index "widgets", ["updated_at"], :name => "index_widgets_on_updated_at"

end
