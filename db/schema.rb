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

ActiveRecord::Schema[8.0].define(version: 2025_03_06_093741) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.date "date"
    t.time "time"
    t.bigint "tenant_id", null: false
    t.bigint "customer_id", null: false
    t.bigint "property_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_appointments_on_customer_id"
    t.index ["property_id"], name: "index_appointments_on_property_id"
    t.index ["tenant_id"], name: "index_appointments_on_tenant_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "phoneno"
    t.bigint "tenant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_customers_on_tenant_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "title"
    t.string "address"
    t.integer "price"
    t.bigint "tenant_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_properties_on_tenant_id"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "property_tags", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id", "tag_id"], name: "index_property_tags_on_property_id_and_tag_id", unique: true
    t.index ["property_id"], name: "index_property_tags_on_property_id"
    t.index ["tag_id"], name: "index_property_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.bigint "tenant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tags_on_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "role"
    t.string "phone"
    t.bigint "tenant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.index ["tenant_id"], name: "index_users_on_tenant_id"
  end

  add_foreign_key "appointments", "customers"
  add_foreign_key "appointments", "properties"
  add_foreign_key "appointments", "tenants"
  add_foreign_key "appointments", "users"
  add_foreign_key "customers", "tenants"
  add_foreign_key "properties", "tenants"
  add_foreign_key "properties", "users"
  add_foreign_key "property_tags", "properties"
  add_foreign_key "property_tags", "tags"
  add_foreign_key "tags", "tenants"
  add_foreign_key "users", "tenants"
end
