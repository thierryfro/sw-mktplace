

desc 'Seed Brands on DB'
task update_brands: :environment do

    brands = BrandUpdater.new
    brands.access_api()

end
