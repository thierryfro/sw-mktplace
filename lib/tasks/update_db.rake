# frozen_string_literal: true

require 'mechanize'

desc 'Seed Brands on DB'
task update_brands: :environment do
  brands = BrandUpdater.new
  brands.access_api
end

desc 'Seed Categories/Subcategories on DB'
task create_categories: :environment do
  def make_request
    api_endpoint = "https://savewhey-api.herokuapp.com/api/v2/categories?&#{ENV['API_SAVEWHEY_USER']}&#{ENV['API_SAVEWHEY_TOKEN']}"
    response = Mechanize.new.get(api_endpoint)
    JSON.parse(response.body)
  rescue StandardError => e
    puts e
  end

  categories = make_request
  categories.each do |category|
    db_category = Category.where(name: category['name']).first
    next if db_category.present?

    new_category = Category.create(category)
    puts "#{new_category.name} category created on db"
    subcategories = new_category.subcategories
    if subcategories.present?
      puts "#{new_category.name}: ** #{subcategories.pluck(:name).join(' -- ')} ** subcategories created on db"      
    end
  end
end
