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

ActiveRecord::Schema.define(:version => 20141107215524) do

  create_table "antraeges", :force => true do |t|
    t.string   "link"
    t.string   "verfasser"
    t.text     "title"
    t.text     "begruendung"
    t.text     "content"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "check"
    t.integer  "geodata_id"
    t.string   "long"
    t.string   "lat"
    t.datetime "last_comment_at"
    t.integer  "docid"
    t.string   "kommune"
    t.datetime "last_updated"
  end

  create_table "antraeges_consultation", :force => true do |t|
    t.string   "status"
    t.string   "action"
    t.string   "committee"
    t.string   "toplfdnr"
    t.text     "meeting"
    t.integer  "silfdnr"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "antraege_id"
    t.date     "update"
    t.text     "decision"
  end

  add_index "antraeges_consultation", ["antraege_id"], :name => "index_antraeges_consultation_on_antraege_id"

  create_table "banners", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.datetime "last_comment_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories_antraeges", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "antraege_id"
  end

  create_table "categories_initiatives", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "initiative_id"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "ancestry"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "user_name"
    t.string   "user_email"
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"
  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"

  create_table "comtest", :id => false, :force => true do |t|
    t.integer  "id"
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
    t.string   "user_email"
  end

  create_table "constructions", :force => true do |t|
    t.text     "description"
    t.text     "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "lat"
    t.string   "long"
    t.text     "description_long"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "geodata_id"
    t.integer  "source_id",        :limit => 8
    t.string   "typ"
    t.datetime "last_comment_at"
    t.text     "content"
  end

  create_table "fotos", :force => true do |t|
    t.string   "title"
    t.string   "file"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "fotos", ["attachable_id"], :name => "index_fotos_on_attachable_id"

  create_table "impressions", :force => true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], :name => "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], :name => "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], :name => "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], :name => "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], :name => "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], :name => "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], :name => "impressionable_type_message_index"
  add_index "impressions", ["user_id"], :name => "index_impressions_on_user_id"

  create_table "initiatives", :force => true do |t|
    t.text     "title"
    t.text     "content"
    t.text     "erreicht"
    t.text     "getan"
    t.integer  "user_id"
    t.text     "lat"
    t.text     "long"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "visible",         :default => true
    t.integer  "geodata_id"
    t.integer  "quarter_id"
    t.integer  "status"
    t.datetime "last_comment_at"
    t.datetime "last_reminder"
    t.string   "kommune_feld"
  end

  create_table "neuigkeitens", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "datum"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "link"
    t.string   "guid"
    t.text     "description"
    t.string   "pubDate"
    t.string   "feed_name"
    t.integer  "initiative_id"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "openinghours"
    t.string   "street"
    t.string   "city"
    t.string   "postalcode"
  end

  create_table "pages", :force => true do |t|
    t.text     "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "quarter_subscriptions", :force => true do |t|
    t.integer  "quarter_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "guid",        :null => false
    t.text     "category"
    t.text     "link"
    t.datetime "pubDate"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "search_subscriptions", :force => true do |t|
    t.string   "query"
    t.string   "email"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.datetime "last_check_at"
    t.string   "confirmation_token"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id",           :null => false
    t.integer  "subscribable_id",   :null => false
    t.string   "subscribable_type", :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "subscriptions", ["user_id", "subscribable_id"], :name => "index_subscriptions_on_user_id_and_subscribable_id", :unique => true

  create_table "supporters", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.integer  "initiative_id", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "supporters", ["user_id", "initiative_id"], :name => "index_supporters_on_user_id_and_initiative_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "role"
    t.string   "provider"
    t.string   "avatar"
    t.string   "kommune"
    t.string   "ortsteil"
    t.string   "partei"
    t.string   "verein"
    t.string   "polit_amt"
    t.string   "verwaltung"
    t.string   "public_fields"
    t.boolean  "nutzungsbedingung"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "jahrgang"
    t.text     "notes"
    t.string   "kommune_name"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "widget_placements", :force => true do |t|
    t.string   "controller"
    t.string   "action"
    t.string   "position"
    t.integer  "widget_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "weight"
  end

  create_table "widgets", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
  end

end
