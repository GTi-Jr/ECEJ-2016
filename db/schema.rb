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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160414223529) do

  create_table "crew_admins", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "crew_admins", ["confirmation_token"], name: "index_crew_admins_on_confirmation_token", unique: true
  add_index "crew_admins", ["email"], name: "index_crew_admins_on_email", unique: true
  add_index "crew_admins", ["reset_password_token"], name: "index_crew_admins_on_reset_password_token", unique: true

  create_table "events", force: :cascade do |t|
    t.string   "name",              default: ""
    t.string   "facilitator",       default: ""
    t.integer  "limit",             default: 1
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "description",       default: ""
    t.string   "facilitator_image"
  end

  create_table "hotels", force: :cascade do |t|
    t.string   "name",       default: ""
    t.string   "extra_info", default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "image"
    t.string   "room_image"
  end

  create_table "lots", force: :cascade do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "limit"
    t.float    "value_not_federated"
    t.float    "value_federated"
    t.datetime "start_date",          null: false
    t.datetime "end_date",            null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.datetime "deadline_1"
    t.datetime "deadline_2"
    t.datetime "deadline_3"
    t.datetime "deadline_4"
  end

  create_table "payments", force: :cascade do |t|
    t.string   "method"
    t.integer  "portions",     default: 1
    t.integer  "portion_paid", default: 0
    t.float    "price"
    t.string   "link_1"
    t.string   "link_2"
    t.string   "link_3"
    t.string   "link_4"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "number"
    t.integer  "capacity"
    t.text     "extra_info", default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "name",       default: ""
    t.integer  "hotel_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "subscribed_at"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "general_register"
    t.string   "cpf"
    t.date     "birthday"
    t.string   "gender"
    t.string   "phone"
    t.string   "federation"
    t.string   "junior_enterprise"
    t.string   "job"
    t.string   "university"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "completed"
    t.text     "special_needs"
    t.boolean  "active",                 default: true
    t.integer  "lot_id"
    t.string   "avatar"
    t.datetime "paid_on"
    t.integer  "room_id"
    t.text     "addres"
    t.string   "state"
    t.string   "transport_required",     default: "Não"
    t.string   "city"
    t.string   "street"
    t.string   "cep"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
