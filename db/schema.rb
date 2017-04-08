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

ActiveRecord::Schema.define(version: 20170404092825) do

  create_table "classifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_cancers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sample_code_number"
    t.integer  "clump_thickness"
    t.integer  "uniformity_of_cell_size"
    t.integer  "uniformity_of_cell_shape"
    t.integer  "marginal_adhesion"
    t.integer  "single_epithelial_cell_size"
    t.integer  "bare_nuclei"
    t.integer  "band_romatin"
    t.integer  "nomal_nucleoli"
    t.integer  "mitoses"
    t.integer  "classification_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["classification_id"], name: "index_data_cancers_on_classification_id", using: :btree
  end

  create_table "data_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "value"
    t.integer  "fiction_id"
    t.integer  "diagnose_id"
    t.datetime "deleted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["diagnose_id"], name: "index_data_users_on_diagnose_id", using: :btree
    t.index ["fiction_id"], name: "index_data_users_on_fiction_id", using: :btree
  end

  create_table "diagnoses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "classification_id"
    t.float    "result",            limit: 24
    t.datetime "deleted_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["classification_id"], name: "index_diagnoses_on_classification_id", using: :btree
    t.index ["user_id"], name: "index_diagnoses_on_user_id", using: :btree
  end

  create_table "fictions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "gender",                 default: 0
    t.date     "birthday"
    t.string   "email",                  default: "", null: false
    t.string   "avatar"
    t.integer  "role",                   default: 0
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "data_cancers", "classifications"
  add_foreign_key "data_users", "diagnoses", column: "diagnose_id"
  add_foreign_key "data_users", "fictions"
  add_foreign_key "diagnoses", "classifications"
  add_foreign_key "diagnoses", "users"
end
