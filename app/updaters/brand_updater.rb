# frozen_string_literal: true

require 'mechanize'
# scrape to index product page

class BrandUpdater
  # Access-Control-Allow-Headers, x-requested-with, x-requested-by

  def initialize(_options = {})
    @page = 1
    @agent = Mechanize.new
    @token = ENV['API_SAVEWHEY_TOKEN']
    @user = ENV['API_SAVEWHEY_USER']
  end

  def access_api
    last_page = last_page()
    while @page <= last_page
      brands = JSON.parse(make_request.body)
      brands.each { |brand| save_brand(brand) }
      @page += 1
    end
  end

  def save_brand(brand)
    #check if already exists on DB
    if Brand.search_name(brand['search_name']).empty?
      b = Brand.create!(brand)
      puts "#{b.name} created on DB"
    end
  end

  def make_request
    api_endpoint = "https://savewhey-api.herokuapp.com/api/v2/brands?page=#{@page}&#{ENV['API_SAVEWHEY_USER']}&#{ENV['API_SAVEWHEY_TOKEN']}"
    @agent.get(api_endpoint)
  rescue StandardError => e
    puts e
  end

  def last_page
    #pagination info are present in header response
    info = make_request.header
    total = info['total'].to_i
    elements = info['per-page'].to_i
    pages = total / elements
    (total % elements).zero? ? pages : pages + 1
  end
end
