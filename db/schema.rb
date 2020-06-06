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

ActiveRecord::Schema.define(version: 2020_05_31_164509) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "street"
    t.string "number"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "complement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.string "search_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

create_table "categories", force: :cascade do |t|
  t.string "name"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end

create_table "cart_offers", force: :cascade do |t|
    t.bigint "offer_id"
    t.integer "quantity"
    t.bigint "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_offers_on_cart_id"
    t.index ["offer_id"], name: "index_cart_offers_on_offer_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "freight_rule_id"
    t.index ["freight_rule_id"], name: "index_carts_on_freight_rule_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "freight_rules", force: :cascade do |t|
    t.integer "price"
    t.string "name"
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_freight_rules_on_store_id"
  end

  create_table "freight_weights", force: :cascade do |t|
    t.integer "min_weight"
    t.integer "max_weight"
    t.bigint "freight_rule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["freight_rule_id"], name: "index_freight_weights_on_freight_rule_id"
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

  create_table "order_offers", force: :cascade do |t|
    t.bigint "offer_id"
    t.bigint "order_id"
    t.float "recorded_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_order_offers_on_offer_id"
    t.index ["order_id"], name: "index_order_offers_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "store_id"
    t.bigint "user_id"
    t.bigint "address_id"
    t.string "preference_id"
    t.string "payment_id"
    t.string "payment_status"
    t.string "payment_status_detail"
    t.string "merchant_order_id"
    t.string "processing_mode"
    t.string "merchant_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["store_id"], name: "index_orders_on_store_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
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
    t.integer "parsed_weight"
    t.integer "api_code"
    t.bigint "brand_id"
    t.bigint "category_id"
    t.bigint "subcategory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_code"
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

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
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
    t.bigint "cart_id"
    t.index ["cart_id"], name: "index_users_on_cart_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "zip_code_zones", force: :cascade do |t|
    t.string "name"
    t.string "district"
    t.string "start_zip_code"
    t.string "end_zip_code"
    t.bigint "freight_rule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["freight_rule_id"], name: "index_zip_code_zones_on_freight_rule_id"
  end


  add_foreign_key "cart_offers", "carts"
  add_foreign_key "cart_offers", "offers"
  add_foreign_key "carts", "freight_rules"
  add_foreign_key "freight_rules", "stores"
  add_foreign_key "freight_weights", "freight_rules"
  add_foreign_key "offer_products", "offers"
  add_foreign_key "offer_products", "products"
  add_foreign_key "offers", "stores"
  add_foreign_key "order_offers", "offers"
  add_foreign_key "order_offers", "orders"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "stores"
  add_foreign_key "orders", "users"
  add_foreign_key "product_photos", "products"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "subcategories"
  add_foreign_key "subcategories", "categories"
  add_foreign_key "taggings", "tags"
  add_foreign_key "user_ratings", "stores"
  add_foreign_key "user_ratings", "users"
  add_foreign_key "user_stores", "stores"
  add_foreign_key "user_stores", "users"
  add_foreign_key "users", "carts"
  add_foreign_key "zip_code_zones", "freight_rules"


  # add_foreign_key "carts", "freight_rules"
  # add_foreign_key "cart_offers", "carts"
  # add_foreign_key "cart_offers", "offers"
  # add_foreign_key "freight_rules", "freight_zones"
  # add_foreign_key "freight_rules", "stores"
  # add_foreign_key "freight_weights", "freight_rules"
  # add_foreign_key "offer_products", "offers"
  # add_foreign_key "offer_products", "products"
  # add_foreign_key "offers", "stores"
  # add_foreign_key "product_photos", "products"
  # add_foreign_key "products", "brands"
  # add_foreign_key "products", "categories"
  # add_foreign_key "products", "subcategories"
  # add_foreign_key "subcategories", "categories"
  # add_foreign_key "taggings", "tags"
  # add_foreign_key "user_ratings", "stores"
  # add_foreign_key "user_ratings", "users"
  # add_foreign_key "user_stores", "stores"
  # add_foreign_key "user_stores", "users"
  # add_foreign_key "users", "carts"
  # add_foreign_key "zip_code_zones", "freight_rules"
end
