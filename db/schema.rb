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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2020_04_01_223359) do
=======
ActiveRecord::Schema.define(version: 2020_04_11_142019) do
>>>>>>> ee674ae357b515c5f7baebc722e99a6d6ed5ec6f

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.string "search_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

<<<<<<< HEAD
=======
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

>>>>>>> ee674ae357b515c5f7baebc722e99a6d6ed5ec6f
  create_table "chart_offers", force: :cascade do |t|
    t.bigint "offer_id"
    t.integer "quantity"
    t.bigint "chart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chart_id"], name: "index_chart_offers_on_chart_id"
    t.index ["offer_id"], name: "index_chart_offers_on_offer_id"
  end

  create_table "charts", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_charts_on_user_id"
  end

  create_table "freight_rules", force: :cascade do |t|
    t.float "limit_price"
    t.float "discount"
    t.bigint "freight_zone_id"
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["freight_zone_id"], name: "index_freight_rules_on_freight_zone_id"
    t.index ["store_id"], name: "index_freight_rules_on_store_id"
  end

  create_table "freight_zones", force: :cascade do |t|
    t.string "zone"
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_freight_zones_on_store_id"
  end

  create_table "offer_products", force: :cascade do |t|
    t.bigint "offer_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_offer_products_on_offer_id"
    t.index ["product_id"], name: "index_offer_products_on_product_id"
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "store_id"
    t.integer "stock"
    t.float "price"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_offers_on_store_id"
  end

  create_table "product_photos", force: :cascade do |t|
    t.string "url"
    t.string "name"
    t.string "size"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_photos_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "weight"
    t.string "flavor"
    t.string "ean"
    t.string "description"
    t.integer "api_code"
    t.bigint "brand_id"
    t.bigint "category_id"
    t.bigint "subcategory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["subcategory_id"], name: "index_products_on_subcategory_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "cnpj", null: false
    t.string "comercial_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.index ["owner_id"], name: "index_stores_on_owner_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "user_ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "store_id"
    t.integer "rating"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_user_ratings_on_store_id"
    t.index ["user_id"], name: "index_user_ratings_on_user_id"
  end

  create_table "user_stores", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_user_stores_on_store_id"
    t.index ["user_id"], name: "index_user_stores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "last_name", null: false
    t.datetime "birthdate", null: false
    t.boolean "admin", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chart_offers", "charts"
  add_foreign_key "chart_offers", "offers"
  add_foreign_key "charts", "users"
  add_foreign_key "freight_rules", "freight_zones"
  add_foreign_key "freight_rules", "stores"
  add_foreign_key "freight_zones", "stores"
  add_foreign_key "offer_products", "offers"
  add_foreign_key "offer_products", "products"
  add_foreign_key "offers", "stores"
  add_foreign_key "product_photos", "products"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "subcategories"
  add_foreign_key "subcategories", "categories"
  add_foreign_key "user_ratings", "stores"
  add_foreign_key "user_ratings", "users"
  add_foreign_key "user_stores", "stores"
  add_foreign_key "user_stores", "users"
end
