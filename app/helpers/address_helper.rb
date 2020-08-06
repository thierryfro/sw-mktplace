module AddressHelper
  def serialize_zipcode(zipcode)
    zipcode = zipcode.split(/\,/).first if zipcode
    zipcode.gsub('-', '')
  end
end
