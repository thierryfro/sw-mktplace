# frozen_string_literal: true

require 'mechanize'

class ProductUpdater
  def initialize(_options = {})
    @page = 1
    @agent = Mechanize.new
    @token = ENV['API_SAVEWHEY_TOKEN']
    @user = ENV['API_SAVEWHEY_USER']
  end

  def access_api
    last_page = last_page()
    while @page <= last_page
      products = JSON.parse(make_request.body)
      products.each { |product| save_product(product) }
      @page += 1
    end
    puts "All products imported"
  end

  def save_product(product)
    # check if already exists on DB
    product.merge!(parse_product(product))
    db_product = Product.where(api_code: product['id']).first
    if db_product.nil?
      product.except!('id', 'brand', 'category', 'subcategory')
      p = Product.create!(product)
      tags = []
      tags << p.brand&.name if p.brand
      tags << p.category&.name if p.category
      tags << p.weight if p.weight
      tags << p.subcategory&.name if p.subcategory
      # p.tag_list = [ p.brand&.name, p.category&.name, p.weight, p.subcategory&.name ]
      p.tag_list = tags

      p.save
      puts "#{p.name} - #{p.weight} - #{p.flavor} created on DB"
    else
      puts "#{db_product.name} - #{db_product.weight} - #{db_product.flavor} already on DB"
    end
  end

  def make_request
    api_endpoint = "https://savewhey-api.herokuapp.com/api/v2/base_suplements?page=#{@page}&#{ENV['API_SAVEWHEY_USER']}&#{ENV['API_SAVEWHEY_TOKEN']}"
    @agent.get(api_endpoint)
  rescue StandardError => e
    puts e
  end

  def last_page
    # pagination info are present in header response
    info = make_request.header
    total = info['total'].to_i
    elements = info['per-page'].to_i
    pages = total / elements
    (total % elements).zero? ? pages : pages + 1
  end

  def parse_product(product)
    {
      'category_id': Category.where(name: product['category']).first&.id,
      'subcategory_id': Subcategory.where(name: product['subcategory']).first&.id,
      'brand_id': Brand.where(search_name: product['brand']['search_name']).first&.id,
      'api_code': product['id']
    }
  end
end
